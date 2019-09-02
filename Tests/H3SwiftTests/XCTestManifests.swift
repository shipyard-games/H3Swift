import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(H3IndexTests.allTests),
        testCase(H3OtherTests.allTests),
    ]
}
#endif
