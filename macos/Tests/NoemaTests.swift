import SwiftUI
import XCTest

final class NoemaTests: XCTestCase {
    func fixture() throws -> Data {
        try Data(contentsOf: Bundle(for: Self.self).url(forResource: "NCT00288912", withExtension: "json")!)
    }

    // The saved NCT00288912 payload still posts the lost sign; a copy with it restored reads fixed.
    func testRegistry() throws {
        let data = try fixture()
        XCTAssertEqual(Check.ctgov(data, outcomes: [1], key: "ciUpperLimit", bad: "0.2"), .wrong(1, of: 1))
        let mended = String(decoding: data, as: UTF8.self).replacingOccurrences(of: "\"ciUpperLimit\": \"0.2\"", with: "\"ciUpperLimit\": \"-0.2\"")
        XCTAssertNotEqual(mended, String(decoding: data, as: UTF8.self))
        XCTAssertEqual(Check.ctgov(Data(mended.utf8), outcomes: [1], key: "ciUpperLimit", bad: "0.2"), .fixed)
        XCTAssertEqual(Check.ctgov(Data("{}".utf8), outcomes: [1], key: "ciUpperLimit", bad: "0.2"), .offline)
    }

    func testOEIS() {
        XCTAssertEqual(Check.oeis(seq: "A399346", drafts: "<a>A399346</a>", entry: ""), .review)
        XCTAssertEqual(Check.oeis(seq: "A399346", drafts: "", entry: "a(38)-a(130) from Joshua Trommel"), .accepted)
        XCTAssertEqual(Check.oeis(seq: "A399346", drafts: "", entry: "Michel Marcus"), .pending)
    }

    func testSummary() {
        let w = Watch(kind: "ctgov", outcomes: [1, 2])
        XCTAssertEqual(Check.summary([w, w], [.wrong(1, of: 2), .fixed]), .wrong(1, of: 4))
        XCTAssertEqual(Check.summary([w], [.fixed]), .fixed)
        XCTAssertNil(Check.summary([], []))
    }

    // The ledger the app bundles decodes, and the library scopes split it the way the sidebar says.
    func testLedger() throws {
        let url = URL(fileURLWithPath: #filePath).deletingLastPathComponent().appendingPathComponent("../../ledger.json")
        let rows = try JSONDecoder().decode(Ledger.self, from: Data(contentsOf: url)).rows
        XCTAssertGreaterThan(rows.count, 100)
        XCTAssertEqual(Set(rows.map(\.id)).count, rows.count, "ids are unique")
        XCTAssertTrue(rows.allSatisfy { Finding.kinds.contains($0.kind) })
        let proved = rows.filter { Scope.proved.holds($0) }
        XCTAssertTrue(proved.allSatisfy { $0.kind == "machine-checked" || $0.kind == "written" })
        XCTAssertTrue(rows.contains { $0.ids.contains { $0.id == "A386859" } })
        XCTAssertTrue(rows.first { $0.ids.contains { $0.id == "A386859" } }!.matches("a386859"))
        XCTAssertFalse(rows[0].matches("zzzz-not-in-any-row"))
    }

    // Renders the window to PNG without launching the app, for a look before anyone sees it.
    // TEST_RUNNER_SHOT=<png> TEST_RUNNER_CATALOG=<discoveries.json> TEST_RUNNER_LEDGER=<ledger.json>
    // optional TEST_RUNNER_SCOPE=reported|proved|candidates|<lane>, TEST_RUNNER_PICK=<id>, TEST_RUNNER_LOOK=light|dark,
    // TEST_RUNNER_QUERY=<text>.
    @MainActor func testShot() throws {
        let env = ProcessInfo.processInfo.environment
        guard let out = env["SHOT"] else { throw XCTSkip("set TEST_RUNNER_SHOT") }
        let all = try JSONDecoder().decode(Catalog.self, from: Data(contentsOf: URL(fileURLWithPath: env["CATALOG"]!))).discoveries
        let rows = try JSONDecoder().decode(Ledger.self, from: Data(contentsOf: URL(fileURLWithPath: env["LEDGER"]!))).rows
        let store = Store(preview: all, findings: rows)
        for d in all {
            for (i, w) in d.watch.enumerated() {
                store.status["\(d.id)/\(i)"] = w.kind == "oeis" ? .review : .wrong((w.outcomes ?? []).count, of: (w.outcomes ?? []).count)
            }
        }
        store.checked = Date()
        let scope: Scope = switch env["SCOPE"] ?? "" {
        case "": .all
        case "reported": .reported
        case "proved": .proved
        case "candidates": .candidates
        case let l: .lane(l)
        }
        let dark = env["LOOK"] != "light"
        let view = ContentView(scope: scope, picked: env["PICK"], query: env["QUERY"] ?? "").environmentObject(store)
            .environment(\.colorScheme, dark ? .dark : .light)
            .frame(width: 1280, height: 800)
        let r = ImageRenderer(content: view)
        r.scale = 2
        var image: CGImage?
        NSAppearance(named: dark ? .darkAqua : .aqua)!.performAsCurrentDrawingAppearance { image = r.cgImage }
        let rep = NSBitmapImageRep(cgImage: try XCTUnwrap(image))
        try rep.representation(using: .png, properties: [:])!.write(to: URL(fileURLWithPath: out))
    }
}
