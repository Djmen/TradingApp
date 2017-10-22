import Foundation
import XCTest

@testable import TradingEngine

class OrderTests: XCTestCase {
  
  func testInitialization() {
    let price:Float = 560.50
    let amount = 50
    let order = Order(currencyPair:"USD/EUR", amount:amount, price:price, side:.buy)
    
    XCTAssertGreaterThan(order.id, 0)
    XCTAssertEqual(order.currencyPair.from, .USD)
    XCTAssertEqual(order.currencyPair.to, .EUR)
    XCTAssertEqual(order.amount, amount)
    XCTAssertEqual(order.price, price)
    XCTAssertEqual(order.side, .buy)
  }
  
  func testIdIncrement() {
    let order1 = Order(currencyPair:CurrencyPair(.UAH, .PLN), amount:40, price:560.40, side:.buy)
    let order2 = Order(currencyPair:"USD/EUR", amount:100, price:530.0, side:.sell)
    
    XCTAssertEqual(order2.id, order1.id+1)
  }
  
  func testMatchOrders() {
    let order1 = Order(currencyPair:CurrencyPair(.USD, .EUR), amount:40, price:560.40, side:.buy)
    let order2 = Order(currencyPair:"USD/EUR", amount:100, price:530.0, side:.sell)
    
    XCTAssertTrue(order1 ~= order2)
    XCTAssertTrue(order2 ~= order1)
  }
  
  func testNotMatchOrder1() {
    //Equal side
    let order1 = Order(currencyPair:CurrencyPair(.USD, .EUR), amount:40, price:560.40, side:.buy)
    let order2 = Order(currencyPair:"USD/EUR", amount:100, price:530.0, side:.buy)
    
    XCTAssertFalse(order1 ~= order2)
    XCTAssertFalse(order2 ~= order1)
  }
  
  func testNotMatchOrder2() {
    //different CurrencyPair
    let order1 = Order(currencyPair:CurrencyPair(.USD, .EUR), amount:40, price:560.40, side:.buy)
    let order2 = Order(currencyPair:"USD/UAH", amount:100, price:530.0, side:.sell)
    
    XCTAssertFalse(order1 ~= order2)
    XCTAssertFalse(order2 ~= order1)
  }
  
  func testNotMatchOrder3() {
    //sale price greater then buy price
    let order1 = Order(currencyPair:CurrencyPair(.USD, .EUR), amount:40, price:560.40, side:.buy)
    let order2 = Order(currencyPair:"USD/EUR", amount:100, price:560.80, side:.sell)
    
    XCTAssertFalse(order1 ~= order2)
    XCTAssertFalse(order2 ~= order1)
  }
  
  func testFill() {
    let order1 = Order(currencyPair:"USD/EUR", amount:80, price:560.53, side:.sell)
    let order2 = Order(currencyPair:"USD/EUR", amount:50, price: 560.55, side:.buy)
    
    XCTAssertTrue(order1 ~= order2)
    let (filledOrder1, filledOrder2) = fillOrders(order1:order1, order2:order2)
    
    XCTAssertFalse(filledOrder1.isClosed)
    XCTAssertEqual(filledOrder1.amount, 30)
    
    XCTAssertTrue(filledOrder2.isClosed)
    XCTAssertEqual(filledOrder2.amount, 0)
    
    //And Otherwise
    let (filledOrder3, filledOrder4) = fillOrders(order1:order2, order2:order1)
    XCTAssertTrue(filledOrder3.isClosed)
    XCTAssertEqual(filledOrder3.amount, 0)
    
    XCTAssertFalse(filledOrder4.isClosed)
    XCTAssertEqual(filledOrder4.amount, 30)
  }
  
  
  static var allTests = [
    ("testInitialization", testInitialization),
    ("testIdIncrement", testIdIncrement),
    ("testMatchOrders", testMatchOrders),
    ("testNotMatchOrder1", testNotMatchOrder1),
    ("testNotMatchOrder2", testNotMatchOrder2),
    ("testNotMatchOrder3", testNotMatchOrder3),
    ("testFill", testFill),
    ]
}
