//
//  ServiceOrchestrator.swift
//  ProServ Mobile
//
//  Created by AJ Johnson on 7/27/23.
//

import Foundation

class ServiceOrchestrator
{
    let _teamService : TeamService
    let _userService : UserService
    let _workoutService : WorkoutService
    
    
    init() {
        self._teamService = TeamService()
        self._userService = UserService()
        self._workoutService = WorkoutService()
    }
}
