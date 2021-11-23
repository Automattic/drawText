import XCTest
@testable import drawText

class TextImageTests: DrawTextTest {

    func testThatInitializingWithAValidFilePathReadsTheFileCorrectly() throws {
        let path = getTestCaseURLForAsset(named: "regular-text-block").path
        let image = try TextImage(string: path)

        XCTAssertEqual(image.html, getTestCase(named: "regular-text-block"))
    }

    func testDrawingOversizedSingleLineText() throws {
        let string = "playstoreres/metadata/source/play_store_screenshot_7.html"
        try TextImage(string: string)
            .applying(fontSize: 140)
            .draw(toFileNamed: "\(#function).png")
    }

    func testDrawingRealText() throws {

        try regularTextBlock()
            .draw(toFileNamed: "\(#function).png")
    }

    func testDrawingLongText() throws {

        let string = getTestCase(named: "large-text-block")
        try TextImage(string: string)
            .applying(fontSize: 140)
            .draw(toFileNamed: "\(#function).png")
    }

    func testDrawingCenteredText() throws {

        try regularTextBlock()
            .applying(fontSize: 100)
            .applying(alignment: .center)
            .draw(toFileNamed: "\(#function).png")
    }

    func testDrawingRTLLanguages() throws {

        let string = getTestCase(named: "rtl-text-block")
        try TextImage(string: string)
            .applying(fontSize: 100)
            .applying(alignment: .center)
            .draw(toFileNamed: "\(#function).png")
    }

    private func regularTextBlock() throws -> TextImage {
        let string = getTestCase(named: "regular-text-block")
        return try TextImage(string: string)
            .applying(fontSize: 100)    // use a sensible default font size
    }
}

fileprivate extension TextImage {
    func applying(styleRule rule: String) -> TextImage {
        self.stylesheet.externalStyles = """
        *{
        \(rule)
        }
        """

        return self
    }

    func applying(fontSize size: Int) -> TextImage {
        self.fontSize = size
        return self
    }

    func applying(alignment: NSTextAlignment) -> TextImage {
        self.alignment = alignment
        return self
    }

    @discardableResult
    func draw(toFileNamed fileName: String) throws -> TextImage {
        let output = try self.draw(inSize: CGSize(width: 500, height: 500))!

        let tempDir = FileManager.default.temporaryDirectory
        let testOutputDir = tempDir.appendingPathComponent("test-output")
        try FileManager.default.createDirectory(at: testOutputDir, withIntermediateDirectories: true)

        File.write(image: output, toFileAtPath: testOutputDir.appendingPathComponent(fileName).path)

        return self
    }
}
