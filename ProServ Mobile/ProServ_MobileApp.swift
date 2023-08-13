//
//  ProServ_MobileApp.swift
//  ProServ Mobile
//
//  Created by AJ Johnson on 7/10/23.
//

import SwiftUI

@main
struct ProServ_MobileApp: App {
    @StateObject var authManager = AuthenticationManager()
    var body: some Scene {
        WindowGroup {
            ContentView(authManager: authManager)
        }
    }
} 
