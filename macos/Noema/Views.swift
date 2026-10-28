import SwiftUI

/// Colours from noema/brand/tokens.css (clrs.cc on a navy page). The font is the system's.
enum Theme {
    static let bg = Color(hex: 0x000F1E), surface = Color(hex: 0x04192E), raised = Color(hex: 0x0A2440)
    static let line = Color(hex: 0x12304D), text = Color(hex: 0xF2F6FA), sub = Color(hex: 0x9DB0C4)
    static let blue = Color(hex: 0x0074D9), link = Color(hex: 0x7FDBFF)
    static let green = Color(hex: 0x2ECC40), orange = Color(hex: 0xFF851B), yellow = Color(hex: 0xFFDC00)

    static func glyph(_ lane: String) -> String {
        ["cs": "cpu", "medicine": "stethoscope", "astronomy": "moon.stars", "math": "function", "physics": "atom",
         "chemistry": "flask", "biology": "leaf", "statistics": "chart.bar", "earth": "globe.americas",
         "information": "antenna.radiowaves.left.and.right"][lane] ?? "circle"
    }

    static func laneName(_ lane: String) -> String {
        ["cs": "Computer science", "medicine": "Medicine", "astronomy": "Astronomy", "math": "Math",
         "information": "Information"][lane] ?? lane.capitalized
    }

    static func color(_ s: Status) -> Color {
        switch s {
        case .wrong: return orange
        case .fixed, .accepted: return green
        case .review: return blue
        case .pending: return yellow
        case .checking, .offline: return sub
        }
    }
}

/// A ScrollView, or a plain stack when the test renders the window to PNG: ImageRenderer cannot draw AppKit-backed scrolling.
struct Scroll<Content: View>: View {
    static var flat: Bool { ProcessInfo.processInfo.environment["SHOT"] != nil }
    @ViewBuilder let content: Content
    var body: some View {
        if Self.flat { Color.clear.overlay(alignment: .top) { content.fixedSize(horizontal: false, vertical: true) }.clipped() } else { ScrollView { content } }
    }
}

extension Color {
    init(hex: UInt32) {
        self.init(red: Double(hex >> 16 & 0xFF) / 255, green: Double(hex >> 8 & 0xFF) / 255, blue: Double(hex & 0xFF) / 255)
    }
}

struct ContentView: View {
    @EnvironmentObject var store: Store
    @State var lane: String?
    @State var picked: String?

    init(lane: String? = nil, picked: String? = nil) {
        _lane = State(initialValue: lane)
        _picked = State(initialValue: picked)
    }

    var lanes: [String] {
        var seen: [String] = []
        for d in store.discoveries where !seen.contains(d.lane) { seen.append(d.lane) }
        return seen
    }
    var shown: [Discovery] { store.discoveries.filter { lane == nil || $0.lane == lane } }
    var current: Discovery? { shown.first { $0.id == picked } ?? shown.first }

    var body: some View {
        HStack(spacing: 0) {
            Sidebar(lanes: lanes, lane: $lane)
                .frame(width: 232)
            Theme.line.frame(width: 1)
            Scroll {
                LazyVStack(spacing: 4) {
                    ForEach(shown) { d in
                        Row(d: d, on: d.id == current?.id).onTapGesture { picked = d.id }
                    }
                }
                .padding(.horizontal, 12).padding(.top, 48).padding(.bottom, 16)
            }
            .frame(width: 344)
            .background(Theme.surface.opacity(0.5))
            Theme.line.frame(width: 1)
            if let d = current { Detail(d: d).id(d.id) } else { Spacer() }
        }
        .background(Theme.bg)
        .foregroundStyle(Theme.text)
        .ignoresSafeArea()
        .preferredColorScheme(.dark)
    }
}

struct Sidebar: View {
    @EnvironmentObject var store: Store
    let lanes: [String]
    @Binding var lane: String?

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack(spacing: 8) {
                Image("Mark", bundle: Bundle(for: Store.self)).resizable().frame(width: 20, height: 20).foregroundStyle(Theme.blue)
                Text("Noema").font(.system(size: 17, weight: .bold))
            }
            .padding(.horizontal, 12).padding(.bottom, 4)
            Text("Discoveries").font(.system(size: 12)).foregroundStyle(Theme.sub)
                .padding(.horizontal, 12).padding(.bottom, 16)
            item(nil, "All", "square.grid.2x2", store.discoveries.count)
            ForEach(lanes, id: \.self) { l in
                item(l, Theme.laneName(l), Theme.glyph(l), store.discoveries.filter { $0.lane == l }.count)
            }
            Spacer()
            VStack(alignment: .leading, spacing: 8) {
                Text(store.checked.map { "Checked \($0.formatted(date: .omitted, time: .shortened))" } ?? "Checking live")
                    .font(.system(size: 12)).foregroundStyle(Theme.sub)
                Button { Task { await store.refresh() } } label: {
                    Label("Check now", systemImage: "arrow.clockwise")
                        .font(.system(size: 14, weight: .semibold))
                        .frame(maxWidth: .infinity, minHeight: 40)
                        .background(Theme.blue, in: Capsule())
                }
                .buttonStyle(.plain)
            }
            .padding(12)
        }
        .padding(.top, 52).padding(.horizontal, 8).padding(.bottom, 8)
    }

    func item(_ l: String?, _ name: String, _ icon: String, _ n: Int) -> some View {
        let on = lane == l
        return HStack(spacing: 12) {
            Image(systemName: icon).font(.system(size: 14)).frame(width: 20).foregroundStyle(on ? Theme.text : Theme.sub)
            Text(name).font(.system(size: 14, weight: on ? .semibold : .regular))
            Spacer()
            Text("\(n)").font(.system(size: 12).monospacedDigit()).foregroundStyle(Theme.sub)
        }
        .padding(.horizontal, 12).frame(height: 36)
        .background(on ? Theme.raised : .clear, in: RoundedRectangle(cornerRadius: 8))
        .contentShape(Rectangle())
        .onTapGesture { lane = l }
    }
}

struct Pill: View {
    let text: String
    let color: Color
    var body: some View {
        Text(text).font(.system(size: 12, weight: .semibold))
            .foregroundStyle(color)
            .padding(.horizontal, 10).frame(height: 24)
            .background(color.opacity(0.16), in: Capsule())
    }
}

struct Row: View {
    @EnvironmentObject var store: Store
    let d: Discovery
    let on: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 8) {
                Image(systemName: Theme.glyph(d.lane)).font(.system(size: 12)).foregroundStyle(Theme.sub)
                Text(Theme.laneName(d.lane).uppercased()).font(.system(size: 11, weight: .semibold)).kerning(0.6)
                    .foregroundStyle(Theme.sub)
                Spacer()
                if let s = store.summary(d) { Pill(text: s.label, color: Theme.color(s)) }
            }
            Text(d.title).font(.system(size: 15, weight: .semibold)).fixedSize(horizontal: false, vertical: true)
            Text(d.plain).font(.system(size: 13)).foregroundStyle(Theme.sub).lineLimit(2)
        }
        .padding(16)
        .background(on ? Theme.raised : .clear, in: RoundedRectangle(cornerRadius: 12))
        .contentShape(Rectangle())
    }
}

struct Detail: View {
    @EnvironmentObject var store: Store
    @Environment(\.openURL) var open
    let d: Discovery

    var body: some View {
        Scroll {
            VStack(alignment: .leading, spacing: 24) {
                VStack(alignment: .leading, spacing: 12) {
                    Label(Theme.laneName(d.lane), systemImage: Theme.glyph(d.lane))
                        .font(.system(size: 13, weight: .semibold)).foregroundStyle(Theme.sub)
                    Text(d.title).font(.system(size: 30, weight: .bold)).fixedSize(horizontal: false, vertical: true)
                    HStack(spacing: 8) {
                        Pill(text: d.level.capitalized, color: Theme.link)
                        Pill(text: date, color: Theme.sub)
                    }
                }
                Text(d.plain).font(.system(size: 16)).lineSpacing(5).foregroundStyle(Theme.text.opacity(0.92))
                    .fixedSize(horizontal: false, vertical: true)

                if d.watch.isEmpty {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Not reported yet").font(.system(size: 13, weight: .semibold)).foregroundStyle(Theme.sub)
                        Text("This one lives in the lab for now. Nothing outside has been asked to change.")
                            .font(.system(size: 14)).foregroundStyle(Theme.sub)
                    }
                }
                ForEach(["oeis", "ctgov"], id: \.self) { kind in
                    let rows = d.watch.enumerated().filter { $0.element.kind == kind }
                    if !rows.isEmpty {
                        VStack(alignment: .leading, spacing: 12) {
                            Text(kind == "oeis" ? "Sent to OEIS" : "Reported to ClinicalTrials.gov, \(rows.count) \(rows.count == 1 ? "trial" : "trials")")
                                .font(.system(size: 13, weight: .semibold)).foregroundStyle(Theme.sub)
                            VStack(spacing: 0) {
                                ForEach(Array(rows.enumerated()), id: \.offset) { j, row in
                                    if j > 0 { Theme.line.frame(height: 1).padding(.leading, 16) }
                                    watchRow(row.element, store.status["\(d.id)/\(row.offset)"] ?? .checking)
                                }
                            }
                            .background(Theme.surface, in: RoundedRectangle(cornerRadius: 12))
                        }
                    }
                }

                Button { open(URL(string: "https://github.com/nulljosh/labs/blob/main/\(d.source)")!) } label: {
                    Label("Read the work", systemImage: "arrow.up.right")
                        .font(.system(size: 14, weight: .semibold)).foregroundStyle(Theme.link)
                }
                .buttonStyle(.plain)
            }
            .frame(maxWidth: 640, alignment: .leading)
            .padding(.horizontal, 40).padding(.top, 56).padding(.bottom, 40)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }

    var date: String {
        let f = DateFormatter(); f.dateFormat = "yyyy-MM-dd"
        return f.date(from: d.date).map { $0.formatted(.dateTime.month(.abbreviated).day().year()) } ?? d.date
    }

    func watchRow(_ w: Watch, _ s: Status) -> some View {
        HStack(spacing: 12) {
            VStack(alignment: .leading, spacing: 4) {
                Text(w.kind == "oeis" ? w.seq ?? "" : w.nct ?? "").font(.system(size: 14, weight: .semibold).monospacedDigit())
                Text(w.what).font(.system(size: 12)).foregroundStyle(Theme.sub)
            }
            Spacer(minLength: 12)
            Pill(text: s.label, color: Theme.color(s))
            Button { open(w.page) } label: {
                Image(systemName: "arrow.up.right.square").font(.system(size: 15)).foregroundStyle(Theme.sub)
            }
            .buttonStyle(.plain).help("Open \(w.name)")
        }
        .padding(.horizontal, 16).frame(minHeight: 56)
    }
}
