//
//  AuthService.swift
//  ProServ Mobile
//
//  Created by AJ Johnson on 8/9/23.
//

import Foundation
//import SwiftKeychainWrapper

class AuthService {
    private let userTokenKey = "userToken"

    static let shared = AuthService()

    private init() { }

    func saveToken(token: String) -> Bool {
        return KeychainWrapper.standard.set(token, forKey: userTokenKey)
    }

    func getToken() -> String? {
        return KeychainWrapper.standard.string(forKey: userTokenKey)
    }

    func deleteToken() -> Bool {
        return KeychainWrapper.standard.removeObject(forKey: userTokenKey)
    }

    func isAuthenticated() -> Bool {
        return getToken() != nil
    }
}
