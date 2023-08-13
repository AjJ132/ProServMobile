//
//  HomeViewModel.swift
//  ProServ Mobile
//
//  Created by AJ Johnson on 7/10/23.
//

import Foundation
import SwiftUI

class LoginViewModel: ObservableObject {
    @Published var isAuthenticated = false
    @Published var isLoading = false
    
    private let authService = AuthService.shared
    private let authManager: AuthenticationManager
    
    var userToken: String? {
        get { return authService.getToken() }
        set { _ = newValue != nil ? authService.saveToken(token: newValue!) : authService.deleteToken() }
    }
    
    
    init(authManager: AuthenticationManager) {
            self.authManager = authManager
        }
    
    func loginUser(email: String, password: String) {
        DispatchQueue.main.async {
                self.isLoading = true
            }
        
        let endpoint = "/api/auth/login"
        let url = URL(string: ServerURL.baseURL + endpoint)!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: Any] = ["Email": email, "Password": password]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error: \(error)")
            } else if let data = data {
                do {
                    if let jsonObject = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                       let token = jsonObject["token"] as? String {
                        DispatchQueue.main.async {
                            self.authManager.authenticate(token: token)
                            self.isLoading = false
                        }
                    }
                } catch {
                    print("Error: \(error)")
                }
            }
        }
        isLoading = false
        
        
        task.resume()
    }
    
    func bypassLogin(){
        DispatchQueue.main.async {
            self.userToken = ""
            self.isAuthenticated = true
        }
        
        
    }
    
    
}
