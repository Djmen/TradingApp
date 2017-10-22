import Foundation

public class TradingEngine {
  private var tradingOrders:[Order] = []
  private var orderPlacedEvent = Event<Order>()
  private var orderClosedEvent = Event<Order>()
  
  public var orders:[Order] { return tradingOrders }
  
  public init() { }
  
  public func addOrder(_ neworder:Order) {
    var newOrder = neworder
    
    for (index, order) in tradingOrders.enumerated() {
      if !order.isClosed && !newOrder.isClosed && newOrder ~= order {
        (newOrder, tradingOrders[index]) = fillOrders(order1:newOrder, order2:order)
        if tradingOrders[index].isClosed {
          orderClosedEvent.raise(data:tradingOrders[index])
        }
        if newOrder.isClosed {
          orderClosedEvent.raise(data:newOrder)
          break
        }
      }
    }
    
    if !newOrder.isClosed {
      tradingOrders.append(newOrder)
      orderPlacedEvent.raise(data:newOrder)
    }
    
    //Remove closed
    tradingOrders = tradingOrders.filter { !$0.isClosed }
  }
  
  public func observeOrderPlacedEvent(handler:@escaping (Order) -> Void) -> Disposable {
    return orderPlacedEvent.addHandler(handler)
  }
  
  public func observeOrderClosedEvent(handler:@escaping (Order) -> Void) -> Disposable {
    return orderClosedEvent.addHandler(handler)
  }
}

extension TradingEngine:CustomStringConvertible {
  
  public var description: String {
    var string = "\n\n┎───────┰───────────────┰───────┰───────┒\n"
    string += "┃SIDE\t┃PRICE\t\t┃AMOUNT\t┃PAIR\t┃\n"
    string += "┠───────╂───────────────╂───────╂───────┨\n"
    for order in tradingOrders {
      string += "\(order)\n"
    }
    string += "┖───────┸───────────────┸───────┸───────┚\n"
    return string
  }
}
