//
//  WorkoutCalendar.swift
//  ProServ Mobile
//
//  Created by AJ Johnson on 8/1/23.
//

import Foundation

class WorkoutCalendarViewModel: ObservableObject {

    @Published var selectedDate = Date()
    @Published var startDateRange = Date()
    @Published var endDateRange = Date()
    var weekStart: String = ""
    var weekEnd: String = ""
    
    init(){
        setWeekForDate(date: Date())
    }
    
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
    
    func setWeekForDate(date: Date) {
        let calendar = Calendar.current
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd"
        
        let components = calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: date)
        
        if let startOfWeek = calendar.date(from: components) {
            startDateRange = startOfWeek
            endDateRange = calendar.date(byAdding: .day, value: 6, to: startOfWeek)!
            
            weekStart = formatter.string(from: startDateRange)
            weekEnd = formatter.string(from: endDateRange)
            
            print("Dates: ")
            print(weekStart)
            print(weekEnd)
        }
    }
    
    func previousWeek(){
        let date = Calendar.current.date(byAdding: .weekOfYear, value: -1, to: startDateRange)!
        setWeekForDate(date: date)
    }
    
    func nextWeek(){
        let date = Calendar.current.date(byAdding: .weekOfYear, value: 1, to: startDateRange)!
        setWeekForDate(date: date)
    }
    
    func selectDate(newDate: Date){
            
    }
}


