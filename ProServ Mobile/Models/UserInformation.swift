//
//  UserInformation.swift
//  ProServ Mobile
//
//  Created by AJ Johnson on 7/18/23.
//

import Foundation

class UserInformation : Decodable {
    var userId: String
    var firstName: String
    var lastName: String
    var birthday: Date
    var userType: String?
    var dateCreated: Date
    var lastAccessed: Date
    var activeUser: Bool
    var teamID: Int
    
    enum CodingKeys: String, CodingKey {
            case userId
            case firstName
            case lastName
            case birthday
            case userType
            case dateCreated
            case lastAccessed
            case activeUser
            case teamID
        }
    
    init(userId: String, firstName: String, lastName: String, birthday: Date, userType: String? = nil, dateCreated: Date, lastAccessed: Date, activeUser: Bool, teamID: Int) {
        self.userId = userId
        self.firstName = firstName
        self.lastName = lastName
        self.birthday = birthday
        self.userType = userType
        self.dateCreated = dateCreated
        self.lastAccessed = lastAccessed
        self.activeUser = activeUser
        self.teamID = teamID
    }
}
