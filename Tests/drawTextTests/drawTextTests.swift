import XCTest

class DrawTextTest: XCTestCase {

    internal func getTestCase(named name: String) -> String {
        let url = getTestCaseURLForAsset(named: name)
        return try! String(contentsOf: url)
            .trimmingCharacters(in: .whitespacesAndNewlines)
    }

    internal func getTestCaseURLForAsset(named name: String, extension fileExtension: String = "txt") -> URL {
         Bundle.module.url(forResource: name, withExtension: fileExtension)!
    }
}
