struct WorkoutResponseJSON: Codable {
    let id: String
    let values: [WorkoutJSON]

    enum CodingKeys: String, CodingKey {
        case id = "$id"
        case values = "$values"
    }
}

struct WorkoutJSON: Codable {
    let id: String
    let workoutId: Int
    let workoutName: String
    let coachId: String
    let notes: String
    let dateToComplete: String
    let coachName: String
    let workoutBlocks: WorkoutBlocksJSON
    let assignedWorkouts: String?

    enum CodingKeys: String, CodingKey {
        case id = "$id"
        case workoutId, workoutName, coachId, notes, dateToComplete, coachName, workoutBlocks, assignedWorkouts
    }
}

struct WorkoutBlocksJSON: Codable {
    let id: String
    let values: [BlockJSON]

    enum CodingKeys: String, CodingKey {
        case id = "$id"
        case values = "$values"
    }
}

struct BlockJSON: Codable {
    let id: String
    let blockId: Int
    let blockOrder: Int
    let workoutId: Int
    let blockName: String
    let blockType: String
    let workout: WorkoutReferenceJSON
    let parameters: ParametersJSON

    enum CodingKeys: String, CodingKey {
        case id = "$id"
        case blockId, blockOrder, workoutId, blockName, blockType, workout, parameters
    }
}

struct WorkoutReferenceJSON: Codable {
    let ref: String

    enum CodingKeys: String, CodingKey {
        case ref = "$ref"
    }
}

struct ParametersJSON: Codable {
    let id: String
    let values: [ParameterJSON]

    enum CodingKeys: String, CodingKey {
        case id = "$id"
        case values = "$values"
    }
}

struct ParameterJSON: Codable {
    let id: String
    let parameterId: Int
    let blockId: Int
    let sValue1: String?
    let sValue2: String?
    let tTime1: String
    let tTime2: String?
    let sDistance1: Int
    let sDistance2: Int?
    let workoutBlock: WorkoutReferenceJSON

    enum CodingKeys: String, CodingKey {
        case id = "$id"
        case parameterId, blockId, sValue1, sValue2, tTime1, tTime2, sDistance1, sDistance2, workoutBlock
    }
}
