//
//  Response Wrapper.swift
//  ProServ Mobile
//
//  Created by AJ Johnson on 7/30/23.
//

import Foundation

struct ResponseWrapper: Decodable {
    let values: [AssignedWorkout]

    private enum CodingKeys: String, CodingKey {
        case values = "$values"
    }
}
