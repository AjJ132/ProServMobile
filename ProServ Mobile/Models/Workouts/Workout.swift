//
//  Workout.swift
//  ProServ Mobile
//
//  Created by AJ Johnson on 7/27/23.
//

import Foundation

public class Workout : Decodable
{
    var WorkoutId : Int
    var WorkoutName : String
    var CoachID : String
    var Notes : String
    
    enum CodingKeys : String, CodingKey{
        case WorkoutId
        case WorkoutName
        case CoachID
        case Notes
    }
    
    init(WorkoutId: Int, WorkoutName: String, CoachID: String, Notes: String) {
        self.WorkoutId = WorkoutId
        self.WorkoutName = WorkoutName
        self.CoachID = CoachID
        self.Notes = Notes
    }
}
