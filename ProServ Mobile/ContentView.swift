//
//  ContentView.swift
//  ProServ Mobile
//
//  Created by AJ Johnson on 7/10/23.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var authManager: AuthenticationManager
    @State private var isLoading = true
    @State private var selectedTab = 0

    
    var body: some View {
        VStack {
            if isLoading{
                SplashScreenView()
            } else if authManager.isAuthenticated {
                TabView(selection: $selectedTab) {
                    HomeView(viewModel: HomeViewModel(), selectedTab: $selectedTab)
                        .badge(2)
                        .tabItem {
                            Label("Home", systemImage: "house.fill")
                        }
                        .tag(0)
                    WorkoutCalendar(viewModel: WorkoutCalendarViewModel())
                        .tabItem {
                            Label("Workouts", systemImage: "figure.run")
                        }
                        .tag(1)
                    SettingsView(viewModel: SettingsViewModel(), authManager: authManager)
                        .badge("!")
                        .tabItem {
                            Label("Account", systemImage: "person.crop.circle.fill")
                        }
                        .tag(2)
                }
                .background(Color.primaryBackground)
            } else {
                LoginView(viewModel: LoginViewModel(authManager: authManager))
            }
        }.onAppear {
            // Simulate a loading delay, or replace with actual loading logic
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                isLoading = false
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(authManager: AuthenticationManager())
    }
}
