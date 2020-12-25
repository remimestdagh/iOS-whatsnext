import Foundation
class TokenManager {
  let userAccount = "accessToken"
  static let shared = TokenManager()

  let secureStore: SecureStore = {
    let accessTokenQueryable = GenericPasswordQueryable(service: "WhatsNext")
    return SecureStore(secureStoreQueryable: accessTokenQueryable)
  }()

  func saveAccessToken(authToken: String) {
    if authToken=="" {
        UserDefaults.standard.set(false, forKey: "isLoggedIn")
    } else {
        UserDefaults.standard.set(true, forKey: "isLoggedIn")
    }
    do {
      try secureStore.setValue(authToken, for: userAccount)
    } catch let exception {
      print("Error saving access token: \(exception)")
    }
  }

  func fetchAccessToken() -> String? {
    do {
      return try secureStore.getValue(for: userAccount)
    } catch let exception {
      print("Error fetching access token: \(exception)")
    }
    return nil
  }

  func clearAccessToken() {
    do {
      return try secureStore.removeValue(for: userAccount)
    } catch let exception {
      print("Error clearing access token: \(exception)")
    }
  }
}
