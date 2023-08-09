//
//  Workout.swift
//  ProServ Mobile
//
//  Created by AJ Johnson on 8/8/23.
//

import Foundation

struct Workout {
    let id: String
    let workoutId: Int
    let workoutName: String
    let coachId: String
    let notes: String
    let dateToComplete: Date
    let coachName: String
    let workoutBlocks: WorkoutBlocks
    let assignedWorkouts: String? // You may want to consider making this a different type if more information is expected in the future
}

struct WorkoutBlocks {
    let id: String
    let blocks: [Block]
}

struct Block {
    let id: String
    let blockId: Int
    let blockOrder: Int
    let workoutId: Int
    let blockName: String
    let blockType: String
    let parameters: Parameters
}


struct Parameters {
    let id: String
    let parameters: [Parameter]
}

struct Parameter {
    let id: String
    let parameterId: Int
    let blockId: Int
    let sValue1: String?  // Consider using more descriptive variable names
    let sValue2: String?
    let tTime1: Date
    let tTime2: Date?
    let sDistance1: Int
    let sDistance2: Int?
}

// Helper extensions to convert from JSON model to UI model
extension Workout {
    init(from workoutJSON: WorkoutJSON) {
        self.id = workoutJSON.id
        self.workoutId = workoutJSON.workoutId
        self.workoutName = workoutJSON.workoutName
        self.coachId = workoutJSON.coachId
        self.notes = workoutJSON.notes
        self.dateToComplete = DateFormatter.iso8601Full.date(from: workoutJSON.dateToComplete) ?? Date()  // Defaulting to current date if parsing fails
        self.coachName = workoutJSON.coachName
        self.workoutBlocks = WorkoutBlocks(from: workoutJSON.workoutBlocks)
        self.assignedWorkouts = workoutJSON.assignedWorkouts
    }
}

extension WorkoutBlocks {
    init(from workoutBlocksJSON: WorkoutBlocksJSON) {
        self.id = workoutBlocksJSON.id
        self.blocks = workoutBlocksJSON.values.map { Block(from: $0) }
    }
}


extension Block {
    init(from blockJSON: BlockJSON) {
        self.id = blockJSON.id
        self.blockId = blockJSON.blockId
        self.blockOrder = blockJSON.blockOrder
        self.workoutId = blockJSON.workoutId
        self.blockName = blockJSON.blockName
        self.blockType = blockJSON.blockType
        self.parameters = Parameters(from: blockJSON.parameters)    // Make sure you have a conversion initializer for Parameters
    }
}

extension Parameters {
    init(from parametersJSON: ParametersJSON) {
        self.id = parametersJSON.id
        self.parameters = parametersJSON.values.map { Parameter(from: $0) }
    }
}


extension Parameter {
    init(from parameterJSON: ParameterJSON) {
        self.id = parameterJSON.id
        self.parameterId = parameterJSON.parameterId
        self.blockId = parameterJSON.blockId
        self.sValue1 = parameterJSON.sValue1
        self.sValue2 = parameterJSON.sValue2
        // Convert string time to Date object
        self.tTime1 = DateFormatter.iso8601Full.date(from: parameterJSON.tTime1) ?? Date()  // This assumes the tTime1 is in the same ISO8601 format. If not, adjust the date format.
        self.tTime2 = parameterJSON.tTime2.flatMap { DateFormatter.iso8601Full.date(from: $0) } // This will return nil if tTime2 is nil
        self.sDistance1 = parameterJSON.sDistance1
        self.sDistance2 = parameterJSON.sDistance2
    }
}


