//
//  Team.swift
//  ProServ Mobile
//
//  Created by AJ Johnson on 7/23/23.
//

import Foundation

class Team  : Decodable{
    var teamID: Int
    var teamName: String
    var location: String
    var coachesCode: String?
    var usersCode: String?
    var terminated: Bool
    var ownerID: String
    
    enum CodingKeys: String, CodingKey {
            case teamID
            case teamName
            case location
            case coachesCode
            case usersCode
            case terminated
            case ownerID
        }
    
    init(teamID: Int, teamName: String, location: String, coachesCode: String?, usersCode: String?, terminated: Bool, ownerID: String) {
        self.teamID = teamID
        self.teamName = teamName
        self.location = location
        self.coachesCode = coachesCode
        self.usersCode = usersCode
        self.terminated = terminated
        self.ownerID = ownerID
    }
}
