//
//  AuthStateManager.swift
//  ProServ Mobile
//
//  Created by AJ Johnson on 8/9/23.
//

import Foundation

class AuthenticationManager: ObservableObject {
    @Published var isAuthenticated: Bool = false
    
    let authService = AuthService.shared
    
    init() {
        isAuthenticated = authService.isAuthenticated()
    }
    
    func authenticate(token: String) {
        authService.saveToken(token: token)
        isAuthenticated = true
    }
    
    func logout() {
        authService.deleteToken()
        isAuthenticated = false
    }
}
