import Foundation

public class Order {
  public enum OperationSide:String {
    case buy
    case sell
  }
  
  private static var idGenerator:Int = 0
  
  let id:Int
  let currencyPair:CurrencyPair
  let amount:Int
  let price:Float
  let side:OperationSide
  
  var isClosed:Bool {return amount == 0}
  
  init(currencyPair:CurrencyPair, amount:Int, price:Float, side:OperationSide) {
    Order.idGenerator += 1
    
    self.id = Order.idGenerator
    self.currencyPair = currencyPair
    self.amount = amount
    self.price = price
    self.side = side
  }
  
  
}

// Function that should return true if values matche
func ~=(a: Order, b: Order) -> Bool {
  guard a.side != b.side && a.currencyPair == b.currencyPair else { return false }
  
  switch a.side {
    case .buy:
      guard a.price >= b.price else {return false}
    case .sell:
      guard a.price <= b.price else {return false}
  }
  
  return true
}

func fillOrders(order1:Order, order2:Order) -> (Order, Order) {
  
  let saldo = order1.amount - order2.amount
  var filledOrder1Amout = 0
  var filledOrder2Amout = 0
  
  if saldo > 0 {
    filledOrder1Amout = saldo
  }
  else if saldo < 0 {
    filledOrder2Amout = abs(saldo)
  }
  
  let newOrder1 = Order(currencyPair:order1.currencyPair,
                        amount:filledOrder1Amout,
                        price:order1.price,
                        side:order1.side)
  let newOrder2 = Order(currencyPair:order2.currencyPair,
                        amount:filledOrder2Amout,
                        price:order2.price,
                        side:order2.side)
  
  return (newOrder1, newOrder2)
}

extension Order:CustomStringConvertible {
  public var description: String { return "┃\(side)\t┃\(price)\t\t┃\(amount)\t┃\(currencyPair)┃" }
}

