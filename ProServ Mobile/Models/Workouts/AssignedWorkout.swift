//
//  AssignedWorkout.swift
//  ProServ Mobile
//
//  Created by AJ Johnson on 7/28/23.
//

import Foundation


class AssignedWorkout : Decodable, Identifiable
{
    var id = UUID()
    var index : Int
    var workoutId : Int
    var workoutDate : Date
    var notes : String?
    var assigneeId : String
    var reportBack : Bool
    var workoutName : String
    var coachName : String

    
    enum CodingKeys: String, CodingKey {
        case index
        case workoutId
        case workoutDate
        case notes
        case assigneeId
        case reportBack
        case workoutName
        case coachName
    }
    
    init(Index: Int, WorkoutId: Int, WorkoutDate: Date, Notes: String, AssigneeId: String, ReportBack: Bool, WorkoutName: String, coachName: String) {
        self.index = Index
        self.workoutId = WorkoutId
        self.workoutDate = WorkoutDate
        self.notes = Notes
        self.assigneeId = AssigneeId
        self.reportBack = ReportBack
        self.workoutName = WorkoutName
        self.coachName = coachName
    }
    
}
