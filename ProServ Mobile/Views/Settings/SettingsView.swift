//
//  SettingsView.swift
//  ProServ Mobile
//
//  Created by AJ Johnson on 8/9/23.
//

import SwiftUI

struct SettingsView: View {
    @ObservedObject var viewModel : SettingsViewModel
    @ObservedObject var authManager: AuthenticationManager
    @State var isToggleOn : Bool = false
    var body: some View {
            NavigationView {
                List {
                    Section(header: Text("General")) {
                        NavigationLink(destination: {
                            List{
                                Section(header: Text("Notifications")) {
                                    VStack(alignment: .leading) {
                                        HStack {
                                            Toggle("All Notifications", isOn: $isToggleOn)
                                                .padding()
                                        }
                                    }
                                }
                            }
                        }) {
                            Text("Notifications") // This is the label that the user will tap
                        }

                        NavigationLink(destination: Text("Account Settings")) {
                            Text("Account Settings")
                        }
                        NavigationLink(destination: Text("Connected Apps")) {
                            Text("Connected Services")
                        }
                    }
                    
                    Section(header: Text("Information")) {
                        NavigationLink(destination: Text("Resources")) {
                            Text("Resources")
                        }
                        NavigationLink(destination: Text("What's new")) {
                            Text("What's new")
                        }
                    }
                    
                    Section(header: Text("Support")) {
                        NavigationLink(destination: Text("Help")) {
                            Text("Help")
                        }
                    }
                    
                    Button("Logout") {
                        authManager.logout()
                    }
                }
                .listStyle(GroupedListStyle())
                .navigationBarTitle("Settings")
            }
        }
}

#Preview {
    SettingsView(viewModel: SettingsViewModel(), authManager: AuthenticationManager())
}
