import AppKit
import SwiftUI

/// Colours from noema/brand/tokens.css (clrs.cc). Dark is the navy page; light is white with cool greys.
enum Theme {
    static let bg = dyn(0xFFFFFF, 0x000F1E), surface = dyn(0xF4F7FA, 0x04192E), raised = dyn(0xE6EEF6, 0x0A2440)
    static let line = dyn(0xDCE4EC, 0x12304D), text = dyn(0x0A1A2A, 0xF2F6FA), sub = dyn(0x56677A, 0x9DB0C4)
    static let blue = Color(hex: 0x0074D9), link = dyn(0x0062B8, 0x7FDBFF)
    static let green = dyn(0x1A8A30, 0x2ECC40), orange = dyn(0xC85A00, 0xFF851B), yellow = dyn(0x8A6D00, 0xFFDC00)
    static let purple = dyn(0x8E0AA1, 0xF07FFF)

    static func dyn(_ light: UInt32, _ dark: UInt32) -> Color {
        Color(nsColor: NSColor(name: nil) { a in
            NSColor(hex: a.bestMatch(from: [.darkAqua, .aqua]) == .darkAqua ? dark : light)
        })
    }

    static func glyph(_ lane: String) -> String {
        ["cs": "cpu", "medicine": "stethoscope", "astronomy": "moon.stars", "math": "function", "physics": "atom",
         "chemistry": "flask", "biology": "leaf", "statistics": "chart.bar", "earth": "globe.americas",
         "information": "antenna.radiowaves.left.and.right", "ai": "brain"][lane] ?? "circle"
    }

    static func laneName(_ lane: String) -> String {
        ["cs": "Computer science", "medicine": "Medicine", "astronomy": "Astronomy", "math": "Math", "physics": "Physics",
         "chemistry": "Chemistry", "biology": "Biology", "statistics": "Statistics", "earth": "Earth science",
         "information": "Information", "ai": "AI"][lane] ?? lane.capitalized
    }

    static func color(_ s: Status) -> Color {
        switch s {
        case .wrong: return orange
        case .fixed, .accepted: return green
        case .review: return link
        case .pending: return yellow
        case .checking, .offline: return sub
        }
    }

    /// A claim class's name and colour. Strength reads left to right: proved, then candidate, then seen.
    static func kind(_ k: String) -> (String, Color) {
        switch k {
        case "machine-checked": return ("Machine-checked", green)
        case "written": return ("Written proof", green)
        case "candidate": return ("Candidate", orange)
        case "literature": return ("Reproduced", purple)
        case "observed": return ("Observed", link)
        default: return ("Note", sub)
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

extension NSColor {
    convenience init(hex: UInt32) {
        self.init(srgbRed: CGFloat(hex >> 16 & 0xFF) / 255, green: CGFloat(hex >> 8 & 0xFF) / 255, blue: CGFloat(hex & 0xFF) / 255, alpha: 1)
    }
}

extension Color {
    init(hex: UInt32) { self.init(nsColor: NSColor(hex: hex)) }
}

/// What the middle column lists.
enum Scope: Hashable {
    case all, reported, proved, candidates, lane(String)

    var title: String {
        switch self {
        case .all: return "Everything"
        case .reported: return "Reported"
        case .proved: return "Proved"
        case .candidates: return "Candidates"
        case let .lane(l): return Theme.laneName(l)
        }
    }

    func holds(_ f: Finding) -> Bool {
        switch self {
        case .all, .reported: return true
        case .proved: return f.kind == "machine-checked" || f.kind == "written"
        case .candidates: return f.kind == "candidate"
        case let .lane(l): return f.lane == l
        }
    }
}

@MainActor
struct ContentView: View {
    @EnvironmentObject var store: Store
    @State var scope: Scope
    @State var picked: String?
    @State var query: String

    init(scope: Scope = .all, picked: String? = nil, query: String = "") {
        _scope = State(initialValue: scope)
        _picked = State(initialValue: picked)
        _query = State(initialValue: query)
    }

    var findings: [Finding] { store.findings.filter { scope.holds($0) && $0.matches(query) } }
    var reports: [Discovery] {
        store.discoveries.filter { query.isEmpty || $0.title.localizedCaseInsensitiveContains(query) || $0.plain.localizedCaseInsensitiveContains(query) }
    }

    var body: some View {
        HStack(spacing: 0) {
            Sidebar(scope: $scope).frame(width: 240)
            Theme.line.frame(width: 1)
            VStack(spacing: 0) {
                ListHeader(title: scope.title, count: scope == .reported ? reports.count : findings.count,
                           noun: scope == .reported ? "report" : "finding", query: $query)
                Scroll {
                    LazyVStack(spacing: 4) {
                        if scope == .reported {
                            ForEach(reports) { d in
                                ReportRow(d: d, on: d.id == (reports.first { $0.id == picked } ?? reports.first)?.id)
                                    .onTapGesture { picked = d.id }
                            }
                        } else {
                            ForEach(findings) { f in
                                FindingRow(f: f, lead: scope.isLane ? nil : f.lane, on: f.id == currentFinding?.id)
                                    .onTapGesture { picked = f.id }
                            }
                        }
                        if (scope == .reported ? reports.count : findings.count) == 0 {
                            Text(query.isEmpty ? "Nothing here yet." : "Nothing matches \u{201C}\(query)\u{201D}.")
                                .font(.body).foregroundStyle(Theme.sub).padding(.top, 32)
                        }
                    }
                    .padding(.horizontal, 12).padding(.bottom, 16)
                }
            }
            .frame(width: 360)
            .background(Theme.surface)
            Theme.line.frame(width: 1)
            Group {
                if scope == .reported {
                    if let d = reports.first(where: { $0.id == picked }) ?? reports.first { ReportDetail(d: d).id(d.id) } else { Spacer() }
                } else if let f = currentFinding {
                    FindingDetail(f: f).id(f.id)
                } else {
                    Spacer()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .background(Theme.bg)
        .foregroundStyle(Theme.text)
        .ignoresSafeArea()
        .onChange(of: scope) { _ in picked = nil }
    }

    var currentFinding: Finding? { findings.first { $0.id == picked } ?? findings.first }
}

extension Scope {
    var isLane: Bool { if case .lane = self { return true } else { return false } }
}

struct ListHeader: View {
    let title: String
    let count: Int
    let noun: String
    @Binding var query: String

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            VStack(alignment: .leading, spacing: 2) {
                Text(title).font(.system(size: 20, weight: .bold))
                Text("\(count) \(noun)\(count == 1 ? "" : "s")").font(.system(size: 12).monospacedDigit()).foregroundStyle(Theme.sub)
            }
            HStack(spacing: 8) {
                Image(systemName: "magnifyingglass").font(.callout).foregroundStyle(Theme.sub)
                if Scroll<EmptyView>.flat {
                    Text(query.isEmpty ? "Search claims, sequences, trials" : query).font(.body)
                        .foregroundStyle(query.isEmpty ? Theme.sub : Theme.text)
                    Spacer()
                } else {
                    TextField("Search claims, sequences, trials", text: $query).textFieldStyle(.plain).font(.body)
                    if !query.isEmpty {
                        Button { query = "" } label: { Image(systemName: "xmark.circle.fill").foregroundStyle(Theme.sub) }
                            .buttonStyle(.plain).help("Clear the search")
                    }
                }
            }
            .padding(.horizontal, 12).frame(height: 32)
            .background(Theme.bg, in: RoundedRectangle(cornerRadius: 8))
            .overlay(RoundedRectangle(cornerRadius: 8).strokeBorder(Theme.line))
        }
        .padding(.horizontal, 24).padding(.top, 48).padding(.bottom, 16)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct Sidebar: View {
    @EnvironmentObject var store: Store
    @Binding var scope: Scope

    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            HStack(spacing: 8) {
                Image("Mark", bundle: Bundle(for: Store.self)).resizable().frame(width: 20, height: 20).foregroundStyle(Theme.blue)
                Text("Noema").font(.system(.title2, weight: .bold))
            }
            .padding(.horizontal, 12).padding(.bottom, 2)
            Text("A thought, checked").font(.callout).foregroundStyle(Theme.sub)
                .padding(.horizontal, 12).padding(.bottom, 20)

            section("Library")
            item(.all, "Everything", "tray.full", store.findings.count)
            item(.reported, "Reported", "paperplane", store.discoveries.count)
            item(.proved, "Proved", "checkmark.seal", store.findings.filter { Scope.proved.holds($0) }.count)
            item(.candidates, "Candidates", "sparkles", store.findings.filter { Scope.candidates.holds($0) }.count)

            section("Fields").padding(.top, 16)
            ForEach(store.lanes, id: \.self) { l in
                item(.lane(l), Theme.laneName(l), Theme.glyph(l), store.findings.filter { $0.lane == l }.count)
            }
            Spacer(minLength: 16)
            VStack(alignment: .leading, spacing: 8) {
                Text(store.checked.map { "Reports checked \($0.formatted(date: .omitted, time: .shortened))" } ?? "Checking reports live")
                    .font(.callout).foregroundStyle(Theme.sub)
                Button { Task { await store.refresh() } } label: {
                    Label("Check now", systemImage: "arrow.clockwise")
                        .font(.system(size: 14, weight: .semibold)).foregroundStyle(.white)
                        .frame(maxWidth: .infinity, minHeight: 36)
                        .background(Theme.blue, in: Capsule())
                }
                .buttonStyle(.plain).help("Reload the ledger and check every report again (⌘R)")
            }
            .padding(12)
        }
        .padding(.top, 52).padding(.horizontal, 8).padding(.bottom, 8)
    }

    func section(_ s: String) -> some View {
        Text(s.uppercased()).font(.system(.subheadline, weight: .semibold)).kerning(0.6).foregroundStyle(Theme.sub)
            .padding(.horizontal, 12).padding(.bottom, 4)
    }

    func item(_ s: Scope, _ name: String, _ icon: String, _ n: Int) -> some View {
        let on = scope == s
        return HStack(spacing: 10) {
            Image(systemName: icon).font(.body).frame(width: 18).foregroundStyle(on ? Theme.blue : Theme.sub)
            Text(name).font(.system(.body, weight: on ? .semibold : .regular))
            Spacer()
            Text("\(n)").font(.system(size: 12).monospacedDigit()).foregroundStyle(Theme.sub)
        }
        .padding(.horizontal, 12).frame(height: 30)
        .background(on ? Theme.raised : .clear, in: RoundedRectangle(cornerRadius: 6))
        .contentShape(Rectangle())
        .onTapGesture { scope = s }
        .accessibilityAddTraits(.isButton)
    }
}

struct Pill: View {
    let text: String
    let color: Color
    var body: some View {
        Text(text).font(.system(.subheadline, weight: .semibold))
            .foregroundStyle(color)
            .padding(.horizontal, 8).frame(height: 22)
            .background(color.opacity(0.14), in: Capsule())
    }
}

/// Short dates, "Nov 24, 2026", from the ledger's ISO days.
func day(_ iso: String) -> String {
    let f = DateFormatter(); f.dateFormat = "yyyy-MM-dd"; f.locale = Locale(identifier: "en_US_POSIX")
    return f.date(from: iso).map { $0.formatted(.dateTime.month(.abbreviated).day().year()) } ?? iso
}

struct FindingRow: View {
    let f: Finding
    let lead: String?
    let on: Bool

    var body: some View {
        let (name, color) = Theme.kind(f.kind)
        VStack(alignment: .leading, spacing: 6) {
            HStack(spacing: 6) {
                if let lead {
                    Image(systemName: Theme.glyph(lead)).font(.subheadline).foregroundStyle(Theme.sub)
                    Text(Theme.laneName(lead).uppercased()).font(.system(.caption, weight: .semibold)).kerning(0.6)
                        .foregroundStyle(Theme.sub)
                }
                Spacer()
                Text(day(f.date)).font(.system(size: 11).monospacedDigit()).foregroundStyle(Theme.sub)
            }
            Text(f.title).font(.system(size: 14, weight: .semibold)).lineLimit(3).fixedSize(horizontal: false, vertical: true)
            Pill(text: name, color: color)
        }
        .padding(12)
        .background(on ? Theme.raised : .clear, in: RoundedRectangle(cornerRadius: 10))
        .contentShape(Rectangle())
        .accessibilityElement(children: .combine).accessibilityAddTraits(.isButton)
    }
}

struct ReportRow: View {
    @EnvironmentObject var store: Store
    let d: Discovery
    let on: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack(spacing: 6) {
                Image(systemName: Theme.glyph(d.lane)).font(.subheadline).foregroundStyle(Theme.sub)
                Text(Theme.laneName(d.lane).uppercased()).font(.system(.caption, weight: .semibold)).kerning(0.6)
                    .foregroundStyle(Theme.sub)
                Spacer()
                if let s = store.summary(d) { Pill(text: s.label, color: Theme.color(s)) }
            }
            Text(d.title).font(.system(size: 14, weight: .semibold)).fixedSize(horizontal: false, vertical: true)
            Text(d.plain).font(.callout).foregroundStyle(Theme.sub).lineLimit(2)
        }
        .padding(12)
        .background(on ? Theme.raised : .clear, in: RoundedRectangle(cornerRadius: 10))
        .contentShape(Rectangle())
        .accessibilityElement(children: .combine).accessibilityAddTraits(.isButton)
    }
}

/// A titled card of rows split by hairlines.
struct Card<Content: View>: View {
    let title: String
    @ViewBuilder let content: Content
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title).font(.system(.body, weight: .semibold)).foregroundStyle(Theme.sub)
            VStack(alignment: .leading, spacing: 0) { content }
                .background(Theme.surface, in: RoundedRectangle(cornerRadius: 12))
                .overlay(RoundedRectangle(cornerRadius: 12).strokeBorder(Theme.line))
        }
    }
}

struct Hairline: View { var body: some View { Theme.line.frame(height: 1).padding(.leading, 16) } }

/// Copy an identifier, then open its page; both are one click.
struct RefRow: View {
    @Environment(\.openURL) var open
    let id: String
    let name: String
    let url: URL
    @State var copied = false

    var body: some View {
        HStack(spacing: 12) {
            VStack(alignment: .leading, spacing: 2) {
                Text(id).font(.system(size: 14, weight: .semibold, design: .monospaced)).textSelection(.enabled)
                Text(name).font(.callout).foregroundStyle(Theme.sub)
            }
            Spacer(minLength: 12)
            Button {
                NSPasteboard.general.clearContents()
                NSPasteboard.general.setString(id, forType: .string)
                copied = true
                Task { try? await Task.sleep(nanoseconds: 1_400_000_000); copied = false }
            } label: {
                Image(systemName: copied ? "checkmark" : "doc.on.doc").font(.body)
                    .foregroundStyle(copied ? Theme.green : Theme.sub).frame(width: 28, height: 28).contentShape(Rectangle())
            }
            .buttonStyle(.plain).help("Copy \(id)").accessibilityLabel("Copy \(id)")
            Button { open(url) } label: {
                Image(systemName: "arrow.up.right.square").font(.system(size: 14)).foregroundStyle(Theme.sub)
                    .frame(width: 28, height: 28).contentShape(Rectangle())
            }
            .buttonStyle(.plain).help("Open on \(name)").accessibilityLabel("Open \(id) on \(name)")
        }
        .padding(.horizontal, 16).frame(minHeight: 52)
    }
}

struct DetailFrame<Content: View>: View {
    @ViewBuilder let content: Content
    var body: some View {
        Scroll {
            VStack(alignment: .leading, spacing: 28) { content }
                .frame(maxWidth: 640, alignment: .leading)
                .padding(.horizontal, 40).padding(.top, 56).padding(.bottom, 40)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

struct FindingDetail: View {
    @Environment(\.openURL) var open
    let f: Finding

    var body: some View {
        let (name, color) = Theme.kind(f.kind)
        DetailFrame {
            VStack(alignment: .leading, spacing: 12) {
                Label(Theme.laneName(f.lane), systemImage: Theme.glyph(f.lane))
                    .font(.system(.body, weight: .semibold)).foregroundStyle(Theme.sub)
                Text(f.title).font(.system(.largeTitle, weight: .bold)).fixedSize(horizontal: false, vertical: true)
                HStack(spacing: 8) { Pill(text: name, color: color); Pill(text: day(f.date), color: Theme.sub) }
            }
            Text(f.claim).font(.title3).lineSpacing(5).foregroundStyle(Theme.text.opacity(0.92))
                .fixedSize(horizontal: false, vertical: true).textSelection(.enabled)

            let steps = [("Claim level", f.level), ("Second check", f.check), ("Literature", f.literature), ("Status", f.status)]
                .filter { !$0.1.isEmpty }
            Card(title: "How it was checked") {
                ForEach(Array(steps.enumerated()), id: \.offset) { i, s in
                    if i > 0 { Hairline() }
                    VStack(alignment: .leading, spacing: 4) {
                        Text(s.0.uppercased()).font(.system(.caption, weight: .semibold)).kerning(0.6).foregroundStyle(Theme.sub)
                        Text(s.1).font(.body).fixedSize(horizontal: false, vertical: true).textSelection(.enabled)
                    }
                    .padding(.horizontal, 16).padding(.vertical, 12).frame(maxWidth: .infinity, alignment: .leading)
                }
            }

            if !f.ids.isEmpty {
                Card(title: "Sources named, \(f.ids.count)") {
                    ForEach(Array(f.ids.enumerated()), id: \.offset) { i, r in
                        if i > 0 { Hairline() }
                        RefRow(id: r.id, name: r.name, url: URL(string: r.url)!)
                    }
                }
            }

            Button { open(f.source) } label: {
                Label("Read it in the ledger", systemImage: "arrow.up.right")
                    .font(.system(size: 14, weight: .semibold)).foregroundStyle(Theme.link)
            }
            .buttonStyle(.plain)
        }
    }
}

struct ReportDetail: View {
    @EnvironmentObject var store: Store
    @Environment(\.openURL) var open
    let d: Discovery

    var body: some View {
        DetailFrame {
            VStack(alignment: .leading, spacing: 12) {
                Label(Theme.laneName(d.lane), systemImage: Theme.glyph(d.lane))
                    .font(.system(.body, weight: .semibold)).foregroundStyle(Theme.sub)
                Text(d.title).font(.system(.largeTitle, weight: .bold)).fixedSize(horizontal: false, vertical: true)
                HStack(spacing: 8) {
                    Pill(text: Theme.kind(d.level).0, color: Theme.kind(d.level).1)
                    Pill(text: day(d.date), color: Theme.sub)
                }
            }
            Text(d.plain).font(.title3).lineSpacing(5).foregroundStyle(Theme.text.opacity(0.92))
                .fixedSize(horizontal: false, vertical: true).textSelection(.enabled)

            if d.watch.isEmpty {
                Card(title: "Not reported yet") {
                    Text("This one lives in the lab for now. Nothing outside has been asked to change.")
                        .font(.body).foregroundStyle(Theme.sub).padding(16)
                }
            }
            ForEach(["oeis", "ctgov"], id: \.self) { kind in
                let rows = d.watch.enumerated().filter { $0.element.kind == kind }
                if !rows.isEmpty {
                    Card(title: kind == "oeis" ? "Sent to OEIS" : "Reported to ClinicalTrials.gov, \(rows.count) \(rows.count == 1 ? "trial" : "trials")") {
                        ForEach(Array(rows.enumerated()), id: \.offset) { j, row in
                            if j > 0 { Hairline() }
                            watchRow(row.element, store.status["\(d.id)/\(row.offset)"] ?? .checking)
                        }
                    }
                }
            }

            Button { open(URL(string: "https://github.com/nulljosh/noema/blob/main/\(d.source)")!) } label: {
                Label("Read the work", systemImage: "arrow.up.right")
                    .font(.system(size: 14, weight: .semibold)).foregroundStyle(Theme.link)
            }
            .buttonStyle(.plain)
        }
    }

    func watchRow(_ w: Watch, _ s: Status) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 8) {
                RefRow(id: w.kind == "oeis" ? w.seq ?? "" : w.nct ?? "", name: w.what, url: w.page)
            }
            HStack { Pill(text: s.label, color: Theme.color(s)) }.padding(.leading, 16).padding(.bottom, 12)
        }
    }
}
