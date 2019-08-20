import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(H3SwiftTests.allTests),
    ]
}
#endif
