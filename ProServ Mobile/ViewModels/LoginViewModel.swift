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
    
    var userToken: String? {
            get {
                return KeychainWrapper.standard.string(forKey: "userToken")
            }
            set {
                if let newValue = newValue {
                    KeychainWrapper.standard.set(newValue, forKey: "userToken")
                } else {
                    KeychainWrapper.standard.removeObject(forKey: "userToken")
                }
            }
        }
    

    
    init() {
        
    }
    
    func loginUser(email: String, password: String) {
            isLoading = true
            let url = URL(string: "http://localhost:5274/api/auth/login")!
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
                        if let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any],
                           let token = jsonObject["token"] as? String {
                            DispatchQueue.main.async {
                                self.userToken = token
                                self.isAuthenticated = true
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
    
    func storeToken(token: String) {
        KeychainWrapper.standard.set(token, forKey: "userToken")
    }


    
}
