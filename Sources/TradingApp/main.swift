import Foundation
import TradingEngine

let arguments = CommandLine.arguments
var path = "../../../inputdata.csv"
if arguments.count == 2 {
  path = arguments[1]
}
else {
  print("USAGE: TradingApp [CSV file path]\nOrders will be loaded from default inputdata.csv\n")
}

do {
  let parser = CVSOrderParser()
  let orders = try parser.orderFromFile(filePath:path)
  
  let engine = TradingEngine()
  let disposable1 = engine.observeOrderPlacedEvent {
    print("OrderPlaced event:\($0)")
  }
  
  let disposable2 = engine.observeOrderClosedEvent {
    print("OrderClosed event:\($0)")
  }
  
  
  for newOrder in orders {
    engine.addOrder(newOrder)
  }
  
  print("\n\nOutput data:\(engine)")
  
  disposable1.dispose()
  disposable2.dispose()
}
catch {
  print("An error occurred: \(error)")
}

