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

    // Renders the window to PNG without launching the app, for a look before anyone sees it.
    @MainActor func testShot() throws {
        guard let out = ProcessInfo.processInfo.environment["SHOT"] else { throw XCTSkip("set TEST_RUNNER_SHOT") }
        let url = URL(fileURLWithPath: ProcessInfo.processInfo.environment["CATALOG"]!)
        let all = try JSONDecoder().decode(Catalog.self, from: Data(contentsOf: url)).discoveries
        let store = Store(preview: all)
        for d in all {
            for (i, w) in d.watch.enumerated() {
                store.status["\(d.id)/\(i)"] = w.kind == "oeis" ? .review : .wrong((w.outcomes ?? []).count, of: (w.outcomes ?? []).count)
            }
        }
        store.checked = Date()
        let pick = ProcessInfo.processInfo.environment["PICK"]
        let view = ContentView(lane: nil, picked: pick).environmentObject(store).frame(width: 1180, height: 760)
        let r = ImageRenderer(content: view)
        r.scale = 2
        let rep = NSBitmapImageRep(cgImage: try XCTUnwrap(r.cgImage))
        try rep.representation(using: .png, properties: [:])!.write(to: URL(fileURLWithPath: out))
    }
}
