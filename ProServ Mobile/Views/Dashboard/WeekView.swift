//
//  WeekView.swift
//  ProServ Mobile
//
//  Created by AJ Johnson on 7/11/23.
//

import SwiftUI

struct WeekView: View {
    let day: String
    let activity: String
    let coach: String

    var body: some View {
        Button(action: {
            // Here is where you put the code to perform when the button is tapped.
            print("\(day) tapped!")
        }) {
            HStack{
                VStack(alignment: .leading){
                    Text(day)
                        .font(.headline)
                        .foregroundColor(.primary)
                    
                    Text(activity)
                        .font(.body)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                VStack(alignment: .leading){
                    Text("Assigned By")
                        .font(.headline)
                        .foregroundColor(.primary)
                    
                    Text(coach)
                        .font(.body)
                        .foregroundColor(.secondary)
                }
            }.padding(.bottom, 20)
        }
        .background(Color.clear) // Add a clear background so the button doesn't highlight when pressed
    }
}

