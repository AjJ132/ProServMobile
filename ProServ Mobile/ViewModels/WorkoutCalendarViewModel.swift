//
//  WorkoutCalendar.swift
//  ProServ Mobile
//
//  Created by AJ Johnson on 8/1/23.
//

import SwiftUI

class WorkoutCalendarViewModel: ObservableObject {
    
    @State var selectedDate = Date()
    
    
    var dateFormatter: DateFormatter {
            let formatter = DateFormatter()
            formatter.dateStyle = .long
            return formatter
        }
    
    func dayOfWeek(from date: Date) -> String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "EEEE"
            return dateFormatter.string(from: date)
        }
}

