import Foundation

public enum Currency:String {
  case AED
  case AFN
  case ALL
  case AMD
  case ANG
  case AOA
  case ARS
  case AUD
  case AWG
  case AZN
  case BAM
  case BBD
  case BDT
  case BGN
  case BHD
  case BIF
  case BMD
  case BND
  case BOB
  case BRL
  case BSD
  case BTN
  case BWP
  case BYN
  case BZD
  case CAD
  case CDF
  case CHF
  case CLP
  case CNY
  case COP
  case CRC
  case CUC
  case CUP
  case CVE
  case CZK
  case DJF
  case DKK
  case DOP
  case DZD
  case EGP
  case ERN
  case ETB
  case EUR
  case FJD
  case FKP
  case GBP
  case GEL
  case GGP
  case GHS
  case GIP
  case GMD
  case GNF
  case GTQ
  case GYD
  case HKD
  case HNL
  case HRK
  case HTG
  case HUF
  case IDR
  case ILS
  case IMP
  case INR
  case IQD
  case IRR
  case ISK
  case JEP
  case JMD
  case JOD
  case JPY
  case KES
  case KGS
  case KHR
  case KMF
  case KPW
  case KRW
  case KWD
  case KYD
  case KZT
  case LAK
  case LBP
  case LKR
  case LRD
  case LSL
  case LYD
  case MAD
  case MDL
  case MGA
  case MKD
  case MMK
  case MNT
  case MOP
  case MRO
  case MUR
  case MVR
  case MWK
  case MXN
  case MYR
  case MZN
  case NAD
  case NGN
  case NIO
  case NOK
  case NPR
  case NZD
  case OMR
  case PAB
  case PEN
  case PGK
  case PHP
  case PKR
  case PLN
  case PYG
  case QAR
  case RON
  case RSD
  case RUB
  case RWF
  case SAR
  case SBD
  case SCR
  case SDG
  case SEK
  case SGD
  case SHP
  case SLL
  case SOS
  case SPL
  case SRD
  case STD
  case SVC
  case SYP
  case SZL
  case THB
  case TJS
  case TMT
  case TND
  case TOP
  case TRY
  case TTD
  case TVD
  case TWD
  case TZS
  case UAH
  case UGX
  case USD
  case UYU
  case UZS
  case VEF
  case VND
  case VUV
  case WST
  case XAF
  case XCD
  case XDR
  case XOF
  case XPF
  case YER
  case ZAR
  case ZMW
  case ZWD
  
  case unknown
}

public struct CurrencyPair {
  let from:Currency
  let to:Currency
  
  public init(_ from:Currency, _ to:Currency) {
    self.from = from
    self.to = to
  }
  
  public var isValid:Bool { return (from != .unknown && to != .unknown) }
}

extension CurrencyPair:ExpressibleByStringLiteral {
  public init(stringLiteral value:String) {
    let components = value.components(separatedBy: "/")
    guard components.count == 2 else {
      self.from = .unknown
      self.to = .unknown
      return
    }
    
    self.from = Currency(rawValue:components[0]) ?? .unknown
    self.to = Currency(rawValue:components[1]) ?? .unknown
  }
  
}

extension CurrencyPair: Equatable {
  public static func == (lhs: CurrencyPair, rhs: CurrencyPair) -> Bool {
    return (lhs.from == rhs.from && lhs.to == rhs.to)
  }
}

extension CurrencyPair:CustomStringConvertible {
  public var description: String { return "\(from)/\(to)" }
}