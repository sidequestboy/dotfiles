import XCTest
import SwiftTreeSitter
import TreeSitterMinilang

final class TreeSitterMinilangTests: XCTestCase {
    func testCanLoadGrammar() throws {
        let parser = Parser()
        let language = Language(language: tree_sitter_minilang())
        XCTAssertNoThrow(try parser.setLanguage(language),
                         "Error loading Minilang grammar")
    }
}
