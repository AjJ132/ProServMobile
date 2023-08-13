//
//  Login.swift
//  ProServ Mobile
//
//  Created by AJ Johnson on 7/20/23.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject var viewModel: LoginViewModel
    
    @State private var email = "aj132@icloud.com"
    @State private var password = "Johnson132"
    

    
    var body: some View {
            ZStack {
                VStack {
                    Text("Login")
                        .font(.largeTitle)
                        .padding(.bottom, 50)
                    
                    VStack(alignment: .leading) {
                        Text("Email")
                            .font(.headline)
                        TextField("Enter email", text: $email)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .autocapitalization(.none)
                            .padding(.bottom)
                        
                        Text("Password")
                            .font(.headline)
                        SecureField("Enter password", text: $password)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .autocapitalization(.none)
                    }
                    .padding(.horizontal, 16)
                    
                    Button(action: {
                        loginUser(email: email, password: password)
                    }) {
                        Text("Login")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(width: 220, height: 60)
                            .background(Color.blue)
                            .cornerRadius(15.0)
                    }
                    Button(action: {
                        viewModel.bypassLogin()
                    }) {
                        Text("Bypass")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(width: 220, height: 60)
                            .background(Color.orange)
                            .cornerRadius(15.0)
                    }
                }
                
                // Here is your loading screen
                if viewModel.isLoading {
                    ActivityIndicator(isAnimating: .constant(true), style: .large)
                }
            }
        }
    
    func loginUser(email: String, password: String) {
           
        
            viewModel.loginUser(email: email, password: password)
        }
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(viewModel: LoginViewModel(authManager: AuthenticationManager()))
    }
}
