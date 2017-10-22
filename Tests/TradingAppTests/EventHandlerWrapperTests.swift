import XCTest
@testable import TradingEngine

class EventHandlerWrapperTests: XCTestCase {
  func testInitialization() {
    let event = Event<Int>()
    let handler:(Int) -> Void = { intValue in }
    
    _ = EventHandlerWrapper(handler: handler,
                              event: event)
    
    let oneMoreEvent = Event<String>()
    let oneMoreHandler:(String) -> Void = { stringValue in }
    
    _ = EventHandlerWrapper(handler:oneMoreHandler, event: oneMoreEvent)
  }
  
  func testInvoke() {
    let event = Event<String>()
    
    var testString:String? = nil
    let handler:(String) -> Void = { strValue in testString = strValue }
    
    let wrapper = EventHandlerWrapper(handler:handler, event: event)
    wrapper.invoke(data:"Hello wrapper")
    
    XCTAssertEqual(testString, "Hello wrapper")
  }

  static var allTests = [
      ("testInitialization", testInitialization),
      ("testInvoke", testInvoke)
  ]
}
