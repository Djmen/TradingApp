import Foundation
import CSV

public enum ParserError:Error {
  case invalidCSVrow
  case invalidCurrencyPairFormat
}

public class CVSOrderParser {
  public init() {}
  
  public func orderFromFile(filePath:String) throws -> [Order] {
    var string:String = ""
    string = try String(contentsOfFile:filePath)
    let orders = try ordersFromCVS(string)
    return orders
  }
  
  public func ordersFromCVS(_ csvString:String) throws -> [Order] {
    let csv = try CSVReader(string: csvString)
    var orders = [Order]()
    while let row = csv.next() {
      guard let side = Order.OperationSide(rawValue:row[0].lowercased()),
            let price = Float(row[1]),
            let amount = Int(row[2])
      else {
        throw ParserError.invalidCSVrow
      }
      
      let pair = CurrencyPair(stringLiteral:row[3])
      guard pair.isValid else { throw ParserError.invalidCurrencyPairFormat }
      
      let order = Order(currencyPair:pair, amount:amount, price:price, side:side)
      orders.append(order)
    }
    
    return orders
  }
} 