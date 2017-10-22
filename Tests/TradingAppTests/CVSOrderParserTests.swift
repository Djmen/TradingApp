import XCTest
@testable import TradingEngine

class CVSOrderParserTests: XCTestCase {

  func testParseCVSString() {
    let cvsString = "BUY,560.50,50,USD/EUR\nBUY,560.55,50,USD/EUR\nBUY,560.60,40,USD/EUR\nSELL,580.60,100,USD/EUR"
    let parser = CVSOrderParser()
    
    var orders:[Order] = []
    do {
      orders = try parser.ordersFromCVS(cvsString)
    } catch  {
      XCTFail("\(error)")
    }
    
    XCTAssertEqual(orders.count, 4)
  }
  
  func testParseCVSStringError() {
    let cvsString = "BAY,560.50,50,USD/EUR"
    let parser = CVSOrderParser()
    
    XCTAssertThrowsError(try parser.ordersFromCVS(cvsString), "Test bad cvs") { error in
      guard let error = error as? ParserError, error == .invalidCSVrow else {
        XCTFail()
        return
      }
    }
  }
  
  static var allTests = [
     ("testParseCVSString", testParseCVSString),
     ("testParseCVSStringError", testParseCVSString),
  ]
}
