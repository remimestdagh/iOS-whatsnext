import Foundation

/// predefines frequent keychain errors
enum SecureStoreError: Error {
  case stringToDataConversionError
  case dataToStringConversionError
  case unhandledError(message: String)
}

extension SecureStoreError: LocalizedError {
  var errorDescription: String? {
    switch self {
    case .stringToDataConversionError:
      return NSLocalizedString("String to Data conversion error", comment: "")
    case .dataToStringConversionError:
      return NSLocalizedString("Data to String conversion error", comment: "")
    case .unhandledError(let message):
      return NSLocalizedString(message, comment: "")
    }
  }
}
