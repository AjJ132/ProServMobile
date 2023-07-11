//
//  CoachContactView.swift
//  ProServ Mobile
//
//  Created by AJ Johnson on 7/11/23.
//

import SwiftUI

import SwiftUI

struct CoachContactView: View {
    let coachName: String
    let coachRole: String

    var body: some View {
        HStack{
            VStack(alignment: .leading){
                Text(coachName)
                    .font(.headline)
                    .foregroundColor(.primary)
                
                Text(coachRole)
                    .font(.body)
                    .foregroundColor(.secondary)
            }
            Spacer()
            
            Button(action: {
                // Here is where you put the code to perform when the button is tapped.
                print("Button tapped!")
            }) {
                Text("Contact")
                    .font(.caption)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.orange)
                    .cornerRadius(10)
            }
        }
    }
}


