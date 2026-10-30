import Foundation

/// One row of ../discoveries.json: a result, its claim level, and where it went outside the lab.
struct Discovery: Decodable, Identifiable, Hashable {
    let id, lane, title, plain, level, date, source: String
    let watch: [Watch]
}

struct Catalog: Decodable { let discoveries: [Discovery] }

/// Something we sent to an outside service, and what to look for there to tell whether it landed.
struct Watch: Decodable, Hashable {
    let kind: String          // "oeis" or "ctgov"
    var seq: String?          // OEIS A-number
    var sent: String?         // what the OEIS edit adds
    var nct: String?          // ClinicalTrials.gov study
    var outcomes: [Int]?      // outcome measures, numbered from 1 in posted order
    var key: String?          // the field that is wrong
    var bad: String?          // its wrong value, still there until the registry fixes it
    var fix: String?          // what it should read

    var name: String { kind == "oeis" ? "OEIS \(seq ?? "")" : "ClinicalTrials.gov \(nct ?? "")" }

    var page: URL {
        kind == "oeis" ? URL(string: "https://oeis.org/\(seq ?? "")")!
                       : URL(string: "https://clinicaltrials.gov/study/\(nct ?? "")?tab=results")!
    }

    var api: URL {
        kind == "oeis" ? URL(string: "https://oeis.org/search?q=id:\(seq ?? "")&fmt=json")!
                       : URL(string: "https://clinicaltrials.gov/api/v2/studies/\(nct ?? "")?fields=OutcomeMeasuresModule")!
    }

    /// One line on what was sent or what is wrong, in plain words.
    var what: String {
        if kind == "oeis" { return "Sent: \(sent ?? "an edit")" }
        let list = (outcomes ?? []).map(String.init).joined(separator: ", ")
        let label = (outcomes ?? []).count == 1 ? "Outcome" : "Outcomes"
        if let fix { return "\(label) \(list): \(key ?? "") reads \(bad ?? ""), should be \(fix)" }
        return "\(label) \(list): labelled \(bad ?? "")"
    }
}

enum Status: Equatable {
    case checking, offline
    case review, accepted, pending            // an OEIS edit
    case wrong(Int, of: Int), fixed           // registry cells still wrong, or all corrected

    var label: String {
        switch self {
        case .checking: return "Checking"
        case .offline: return "Offline"
        case .review: return "In review"
        case .accepted: return "Accepted"
        case .pending: return "Not in yet"
        case let .wrong(n, total): return total == 1 ? "Still wrong" : "\(n) of \(total) still wrong"
        case .fixed: return "Fixed"
        }
    }
}

/// Pure readers for each service's reply, kept apart from the network so a test can feed them saved payloads.
enum Check {
    /// OEIS: our edit is in review while the draft list names the sequence, accepted once the entry credits us.
    static func oeis(seq: String, drafts: String, entry: String, author: String = "Joshua Trommel") -> Status {
        if drafts.contains(seq) { return .review }
        return entry.contains(author) ? .accepted : .pending
    }

    /// ClinicalTrials.gov: count the listed outcome measures that still carry the wrong value anywhere inside them.
    static func ctgov(_ data: Data, outcomes: [Int], key: String, bad: String) -> Status {
        guard let root = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
              let results = root["resultsSection"] as? [String: Any],
              let module = results["outcomeMeasuresModule"] as? [String: Any],
              let measures = module["outcomeMeasures"] as? [Any] else { return .offline }
        let wrong = outcomes.filter { $0 >= 1 && $0 <= measures.count && holds(measures[$0 - 1], key: key, value: bad) }
        return wrong.isEmpty ? .fixed : .wrong(wrong.count, of: outcomes.count)
    }

    static func holds(_ node: Any, key: String, value: String) -> Bool {
        if let d = node as? [String: Any] {
            if let v = d[key], "\(v)" == value { return true }
            return d.values.contains { holds($0, key: key, value: value) }
        }
        if let a = node as? [Any] { return a.contains { holds($0, key: key, value: value) } }
        return false
    }

    /// A discovery's overall state: any registry cell still wrong wins, then review, then done.
    static func summary(_ watches: [Watch], _ all: [Status]) -> Status? {
        if all.isEmpty { return nil }
        if all.contains(.checking) { return .checking }
        let wrong = all.reduce(0) { acc, s in
            if case let .wrong(n, _) = s { return acc + n }
            return acc
        }
        if wrong > 0 { return .wrong(wrong, of: watches.reduce(0) { $0 + ($1.outcomes ?? []).count }) }
        if all.contains(.offline) { return .offline }
        if all.contains(.review) { return .review }
        if all.contains(.pending) { return .pending }
        return all.allSatisfy({ $0 == .fixed }) ? .fixed : .accepted
    }
}

@MainActor
final class Store: ObservableObject {
    @Published var discoveries: [Discovery] = []
    @Published var status: [String: Status] = [:]   // keyed by "discovery id/watch index"
    @Published var checked: Date?

    static let remote = URL(string: "https://raw.githubusercontent.com/nulljosh/noema/main/discoveries.json")!

    init(preview: [Discovery]? = nil) {
        if let preview { discoveries = preview; return }
        if let url = Bundle.main.url(forResource: "discoveries", withExtension: "json"),
           let data = try? Data(contentsOf: url), let c = try? JSONDecoder().decode(Catalog.self, from: data) {
            discoveries = c.discoveries
        }
    }

    func statuses(_ d: Discovery) -> [Status] { d.watch.indices.map { status["\(d.id)/\($0)"] ?? .checking } }
    func summary(_ d: Discovery) -> Status? { Check.summary(d.watch, statuses(d)) }

    /// Pull the newest list from GitHub (the bundled copy stays if that fails), then check every watch once.
    func refresh() async {
        if let data = try? await Self.get(Self.remote), let c = try? JSONDecoder().decode(Catalog.self, from: data) {
            discoveries = c.discoveries
        }
        for d in discoveries { for i in d.watch.indices { status["\(d.id)/\(i)"] = .checking } }
        let drafts = (try? await Self.get(URL(string: "https://oeis.org/draft?user=Joshua%20Trommel")!)).map { String(decoding: $0, as: UTF8.self) }
        await withTaskGroup(of: (String, Status).self) { group in
            for d in discoveries {
                for (i, w) in d.watch.enumerated() {
                    group.addTask { ("\(d.id)/\(i)", await Self.check(w, drafts: drafts)) }
                }
            }
            for await (k, s) in group { status[k] = s }
        }
        checked = Date()
    }

    nonisolated static func check(_ w: Watch, drafts: String?) async -> Status {
        guard let data = try? await get(w.api) else { return .offline }
        if w.kind == "oeis" {
            guard let drafts else { return .offline }
            return Check.oeis(seq: w.seq ?? "", drafts: drafts, entry: String(decoding: data, as: UTF8.self))
        }
        return Check.ctgov(data, outcomes: w.outcomes ?? [], key: w.key ?? "", bad: w.bad ?? "")
    }

    nonisolated static func get(_ url: URL) async throws -> Data {
        var req = URLRequest(url: url, timeoutInterval: 30)
        req.setValue("Noema/1.0 (+https://noema.jaybulb.com)", forHTTPHeaderField: "User-Agent")  // OEIS refuses blank agents
        let (data, response) = try await URLSession.shared.data(for: req)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { throw URLError(.badServerResponse) }
        return data
    }
}
