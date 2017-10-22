import XCTest
@testable import TradingEngine

class EventTests: XCTestCase {
  func testInitialization() {
    let event = Event<Int>()
    XCTAssertEqual(event.handlersCount, 0)
  }
  
  func testAddHandler() {
    let event = Event<String>()
    _ = event.addHandler { string in  }
    XCTAssertEqual(event.handlersCount, 1)
    
    _ = event.addHandler { string in }
    _ = event.addHandler { string in }
    XCTAssertEqual(event.handlersCount, 3)
  }
  
  func testDispose() {
    let event = Event<Float>()
    let handler  = event.addHandler { string in }
    let handler2 = event.addHandler { string in }
    
    XCTAssertEqual(event.handlersCount, 2)
    
    handler.dispose()
    XCTAssertEqual(event.handlersCount, 1)
    
    handler2.dispose()
    XCTAssertEqual(event.handlersCount, 0)
  }
  
  func testRaise() {
    let event = Event<String>()
    var testString:String? = nil
    
    let handler = event.addHandler { testString = $0 }
    event.raise(data:"Raise")
    XCTAssertEqual(testString, "Raise")
    
    handler.dispose()
    event.raise(data:"Hello")
    XCTAssertEqual(testString, "Raise")
  }
  
  func testRaiseThuple() {
    let event = Event<(Int, String)>()
    
    var testInt:Int? = nil
    var testString:String? = nil
    
    let handler = event.addHandler { intVal, stringVal in
        testInt = intVal
        testString = stringVal
    }
    event.raise(data:(300, "spartans"))
    
    XCTAssertEqual(testInt, 300)
    XCTAssertEqual(testString, "spartans")
  }
  

  static var allTests = [
       ("testInitialization", testInitialization),
       ("testAddHandler", testAddHandler),
       ("testDispose", testDispose),
       ("testRaise", testRaise),
       ("testRaiseThuple", testRaiseThuple),
  ]
}
