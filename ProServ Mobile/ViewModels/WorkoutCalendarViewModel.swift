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
    
    @Published var selectedDateIndex = 0
    
    let calendar = Calendar.current
    @Published var dates: [Date] = []
    
    @Published var userWorkoutsByWeek: DataState<[Workout]> = .idle {
        didSet {
            switch userWorkoutsByWeek {
            case .loaded(let workouts):
                weeksWorkouts = workouts
            default:
                weeksWorkouts = []
            }
        }
    }
    
    @Published var selectedWorkout : Workout?
    @Published var weeksWorkouts : [Workout]
    @Published var testSelectedWorkout: Workout?
    
    let _serviceOrchestrator : ServiceOrchestrator
    
    
    
    init(){
        self._serviceOrchestrator = ServiceOrchestrator()
        //self.selectedWorkout = Work // You might want to provide a default Workout object or make it optional
        self.weeksWorkouts = []
        self.startDateRange = Date() // If this isn't what you want, adjust accordingly
        self.endDateRange = Date() // Same as above
        
        setWeekForDate(date: Date())
        
        //Set selectedDate to the index of today in the week
        for i in dates {
            if calendar.isDate(i, inSameDayAs: Date()) {
                selectedDate = i
                break
            }
        }
        
        //Get workouts for the selected week and set the selected workout to today
        getWorkoutsByDateRange(startDate: startDateRange, endDate: endDateRange) {
            self.setTodaysWorkout(newDate: Date())
        }
        
        //Init test workout
    }
    
    
    func setTodaysWorkout(newDate: Date) {
        let calendar = Calendar.current
        
        let workoutsForToday = self.weeksWorkouts.filter {
            calendar.isDate($0.dateToComplete, inSameDayAs: newDate)
        }
        
        // Exit the function if there are no workouts for today
        guard let selectedWorkout = workoutsForToday.first else {
            print("Leaving")
            return
        }
        
        self.selectedWorkout = selectedWorkout
        print("Got Todays Workout \(selectedWorkout.workoutName)")
    }
    
    
    //get workouts for the currently selected date range. This should be exactly one week, Sunday to Saturday
    func getWorkoutsByDateRange(startDate: Date, endDate: Date, completion: @escaping () -> Void) {
        self.userWorkoutsByWeek = .loading
        
        self._serviceOrchestrator._workoutService.getWorkoutsInDateRange(startDate: startDate, endDate: endDate) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let userInfo):
                    self?.userWorkoutsByWeek = .loaded(userInfo)
                case .failure(let error):
                    self?.userWorkoutsByWeek = .error(error)
                }
                completion() // Once the async task is complete, call the completion handler.
            }
        }
    }
    
    
    
    func selectDate(newDate: Date) {
        selectedDate = newDate
    }
    
    func indexOfDate(_ targetDate: Date) -> Int? {
        return dates.firstIndex { calendar.isDate($0, inSameDayAs: targetDate) }
    }
    
    func computeDates() {
        dates = (0..<7).compactMap { calendar.date(byAdding: .day, value: $0, to: startDateRange) }
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
    
    func setDateRanges(){
        
    }
    
    func setWeekForDate(date: Date) {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd"
        
        let components = calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: date)
        
        if let startOfWeek = calendar.date(from: components) {
            startDateRange = startOfWeek
            endDateRange = calendar.date(byAdding: .day, value: 6, to: startOfWeek)!
            
            weekStart = formatter.string(from: startDateRange)
            weekEnd = formatter.string(from: endDateRange)
            
            // Compute the dates for this week
            computeDates()
            
            // Set the selectedDate to the first date in the dates array
            selectedDate = dates.first ?? Date()
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
    
    func setTestWorkouts(){
        let jsonString = """
                {
                    "$id": "1",
                    "$values": [
                        {
                            "$id": "2",
                            "workoutId": 6,
                            "workoutName": "long run 2",
                            "coachId": "0ff2160c-596f-4d89-bba3-3a15ea3e81d1",
                            "notes": "test for long run 2",
                            "dateToComplete": "2023-08-08T10:12:45.131875-04:00",
                            "workoutBlocks": {
                                "$id": "3",
                                "$values": [
                                    {
                                        "$id": "4",
                                        "blockId": 5,
                                        "blockOrder": 0,
                                        "workoutId": 6,
                                        "blockName": "Long Run",
                                        "blockType": "Long Run",
                                        "workout": {
                                            "$ref": "2"
                                        },
                                        "parameters": {
                                            "$id": "5",
                                            "$values": [
                                                {
                                                    "$id": "6",
                                                    "parameterId": 4,
                                                    "blockId": 5,
                                                    "sValue1": null,
                                                    "sValue2": null,
                                                    "tTime1": "00:07:30",
                                                    "tTime2": null,
                                                    "sDistance1": 3,
                                                    "sDistance2": null,
                                                    "workoutBlock": {
                                                        "$ref": "4"
                                                    }
                                                }
                                            ]
                                        }
                                    }
                                ]
                            },
                            "assignedWorkouts": null
                        }
                    ]
                }
                """
        
        let jsonData = jsonString.data(using: .utf8)!
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601Full)
        
        do {
            let response = try decoder.decode(WorkoutResponseJSON.self, from: jsonData)
            if let firstWorkout = response.values.first {
                self.testSelectedWorkout = Workout(from: firstWorkout)
            }
            print("Decoded and set testSelectedWorkout successfully")
        } catch {
            print("Failed to decode JSON: \(error)")
        }
    }
    
}


