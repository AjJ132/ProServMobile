//
//  WeekView.swift
//  ProServ Mobile
//
//  Created by AJ Johnson on 7/11/23.
//

import SwiftUI

struct WeekView: View {
    let day: Date
    let activity: String
    let coach: String
    
    var dayOfWeek: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE" // "EEEE" will give you the full name of the day
        return dateFormatter.string(from: day)
    }
    
    var isToday: Bool {
        return Calendar.current.isDateInToday(day)
    }



    var body: some View {
        Button(action: {
            // Here is where you put the code to perform when the button is tapped.
            print("\(day) tapped!")
        }) {
            HStack{
                VStack(alignment: .leading){
                    Text(dayOfWeek)
                        .font(.headline)
                        .foregroundColor(.primary)
                    
                    Text(activity)
                        .font(.body)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
               
            }.padding(.bottom, 20)
        }
        .background(Color.clear) // Add a clear background so the button doesn't highlight when pressed
    }
}

