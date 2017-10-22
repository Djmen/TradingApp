import XCTest
@testable import TradingEngine

class TradingEngineTests: XCTestCase {
  
  func testInitialization() {
    let engine = TradingEngine()
    XCTAssertEqual(engine.orders.count, 0)
  }

  func testAddOrder() {
    let engine = TradingEngine()
    let order = Order(currencyPair:"USD/EUR", amount:80, price:560.40, side:.buy)
    engine.addOrder(order)
    XCTAssertEqual(engine.orders.count, 1)
  }
  
  func testAddOrderAndFill() {
    let engine = TradingEngine()
    let order1 = Order(currencyPair:"USD/EUR", amount:80, price:560.53, side:.sell)
    let order2 = Order(currencyPair:"USD/EUR", amount:50, price: 560.55, side:.buy)
    let order3 = Order(currencyPair:"USD/EUR", amount:30, price: 560.55, side:.buy)
    engine.addOrder(order1)
    XCTAssertEqual(engine.orders.count, 1)
    
    engine.addOrder(order2)
    XCTAssertEqual(engine.orders.count, 1)
    XCTAssertEqual(engine.orders.first?.side, .sell)
    XCTAssertEqual(engine.orders.first?.amount, 30)
    
    engine.addOrder(order3)
    XCTAssertTrue(engine.orders.isEmpty)
  }
  
  func testEventOrderPlaced() {
    let engine = TradingEngine()
    let order1 = Order(currencyPair:"USD/EUR", amount:80, price:560.53, side:.sell)
    
    var observedOrder:Order? = nil
    let disposible = engine.observeOrderPlacedEvent { observedOrder = $0 }
    engine.addOrder(order1)
    
    XCTAssertNotNil(observedOrder)
    disposible.dispose()
  }
  
  func testEventOrderClosed() {
    let engine = TradingEngine()
    let order1 = Order(currencyPair:"USD/EUR", amount:80, price:560.53, side:.sell)
    let order2 = Order(currencyPair:"USD/EUR", amount:40, price:560.60, side:.buy)
    
    var observedOrder:Order? = nil
    let disposible = engine.observeOrderClosedEvent { observedOrder = $0 }
    engine.addOrder(order1)
    XCTAssertNil(observedOrder)
    
    engine.addOrder(order2)
    XCTAssertNotNil(observedOrder)
    disposible.dispose()
  }
  
  static var allTests = [
      ("testInitialization", testInitialization),
      ("testAddOrder", testAddOrder),
      ("testAddOrderAndFill", testAddOrderAndFill),
      ("testEventOrderClosed", testEventOrderClosed),
  ]
}
