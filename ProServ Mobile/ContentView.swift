//
//  ContentView.swift
//  ProServ Mobile
//
//  Created by AJ Johnson on 7/10/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = LoginViewModel()

    var body: some View {
        VStack {
            if viewModel.isAuthenticated {
                TabView {
                    HomeView(viewModel: HomeViewModel())
                        .badge(2)
                        .tabItem {
                            Label("Home", systemImage: "house.fill")
                        }
                    HomeView(viewModel: HomeViewModel())
                        .tabItem {
                            Label("Workouts", systemImage: "figure.run")
                        }
                    HomeView(viewModel: HomeViewModel())
                        .badge("!")
                        .tabItem {
                            Label("Account", systemImage: "person.crop.circle.fill")
                        }
                }
                .background(Color.primaryBackground)
            } else {
                LoginView(viewModel: viewModel)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
