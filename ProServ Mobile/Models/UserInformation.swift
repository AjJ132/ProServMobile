//
//  UserInformation.swift
//  ProServ Mobile
//
//  Created by AJ Johnson on 7/18/23.
//

import Foundation

class UserInformation : Decodable {
    var userId: String
    var firstName: String?
    var lastName: String?
    var city: String?
    var state: String?
    var height: String?
    var weight: Int
    var isInHighschool: Bool
    var school: String?
    var birthday: Date
    var gender: String?
    var userType: String?
    var reportsTo: String?
    var dateCreated: Date
    var lastAccessed: Date
    var activeUser: Bool
    var teamID: Int
    
    enum CodingKeys: String, CodingKey {
            case userId
            case firstName
            case lastName
            case city
            case state
            case height
            case weight
            case isInHighschool
            case school
            case birthday
            case gender
            case userType
            case reportsTo
            case dateCreated
            case lastAccessed
            case activeUser
            case teamID
        }
    
    init(userId: String, firstName: String? = nil, lastName: String? = nil, city: String? = nil, state: String? = nil, height: String? = nil, weight: Int, isInHighschool: Bool, school: String? = nil, birthday: Date, gender: String? = nil, userType: String? = nil, reportsTo: String? = nil, dateCreated: Date, lastAccessed: Date, activeUser: Bool, teamID: Int) {
        self.userId = userId
        self.firstName = firstName
        self.lastName = lastName
        self.city = city
        self.state = state
        self.height = height
        self.weight = weight
        self.isInHighschool = isInHighschool
        self.school = school
        self.birthday = birthday
        self.gender = gender
        self.userType = userType
        self.reportsTo = reportsTo
        self.dateCreated = dateCreated
        self.lastAccessed = lastAccessed
        self.activeUser = activeUser
        self.teamID = teamID
    }
}
