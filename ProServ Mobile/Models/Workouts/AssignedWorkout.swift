//
//  AssignedWorkout.swift
//  ProServ Mobile
//
//  Created by AJ Johnson on 7/28/23.
//

import Foundation


class AssignedWorkout : Decodable
{
    var Index : Int
    var WorkoutId : Int
    var WorkoutDate : Date
    var Notes : String
    var AssigneeId : String
    var ReportBack : Bool
    var WorkoutName : String
    
    enum CodingKeys : String, CodingKey{
        case Index
        case WorkoutId
        case WorkoutDate
        case Notes
        case AssigneeId
        case ReportBack
        case WorkoutName
    }
    
    init(Index: Int, WorkoutId: Int, WorkoutDate: Date, Notes: String, AssigneeId: String, ReportBack: Bool, WorkoutName: String) {
        self.Index = Index
        self.WorkoutId = WorkoutId
        self.WorkoutDate = WorkoutDate
        self.Notes = Notes
        self.AssigneeId = AssigneeId
        self.ReportBack = ReportBack
        self.WorkoutName = WorkoutName
    }
    
}
