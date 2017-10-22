import XCTest
@testable import TradingEngine

class CurrancyPairTests: XCTestCase {
  func testInitialization() {
    let pair = CurrencyPair(.USD, .EUR)
    
    XCTAssertEqual(pair.from, .USD)
    XCTAssertEqual(pair.to, .EUR)
    
    XCTAssertTrue(pair.isValid)
  }

  func testLiteralInitialization() {
    let pair:CurrencyPair = "ZWD/PLN"
    
    XCTAssertEqual(pair.from, .ZWD)
    XCTAssertEqual(pair.to, .PLN)
    
    XCTAssertTrue(pair.isValid)
  }
  
  func testLiteralInitializationBadString() {
    let pair:CurrencyPair = "UAH/LOL"
    
    XCTAssertEqual(pair.from, .UAH)
    XCTAssertEqual(pair.to, .unknown)
    
    XCTAssertFalse(pair.isValid)
  }
  
  func testLiteralInitializationBadString2() {
    let pair:CurrencyPair = "EUR"
    
    XCTAssertEqual(pair.from, .unknown)
    XCTAssertEqual(pair.to, .unknown)
    
    XCTAssertFalse(pair.isValid)
  }
    
  func testLiteralInitializationBadString3() {
    let pair:CurrencyPair = "UAH/USD/EUR"
    
    XCTAssertEqual(pair.from, .unknown)
    XCTAssertEqual(pair.to, .unknown)
    
    XCTAssertFalse(pair.isValid)
  }
  
  func testEqutable() {
    let pairA = CurrencyPair(.USD, .EUR)
    let pairB:CurrencyPair = "USD/EUR"
    let pairC = CurrencyPair(.EUR, .USD)
    
    XCTAssertEqual(pairA, pairB)
    XCTAssertNotEqual(pairA, pairC)
    XCTAssertNotEqual(pairB, pairC)
    
  }
  
  static var allTests = [
      ("testInitialization", testInitialization),
      ("testLiteralInitialization", testLiteralInitialization),
      ("testLiteralInitializationBadString", testLiteralInitializationBadString),
      ("testLiteralInitializationBadString2", testLiteralInitializationBadString2),
      ("testEqutable", testEqutable),
  ]
}
