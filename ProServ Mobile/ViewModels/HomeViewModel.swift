//
//  HomeViewModel.swift
//  ProServ Mobile
//
//  Created by AJ Johnson on 7/10/23.
//

import Foundation
class HomeViewModel: ObservableObject {
    // @Published properties will automatically update the view when changed.
    //@Published var yourModels = [YourModel]()
    
    //Test Variable
    
    let weekData: [WeekData] = [
            WeekData(day: "Monday", activity: "Cooldown", coach: "Coach Sarah"),
            WeekData(day: "Tuesday", activity: "Sprint", coach: "Coach Sarah"),
            WeekData(day: "Wednesday", activity: "Tempo", coach: "Coach Sarah"),
            WeekData(day: "Thursday", activity: "No Workout", coach: "Coach Sarah"),
            WeekData(day: "Friday", activity: "Weights", coach: "Coach Sarah")
        ]
    
    let coachContactData: [CoachContact] = [
        CoachContact(coach: "Sarah Hendrick", coachRole: "Head Coach"),
        CoachContact(coach: "Faith Bobak", coachRole: "Assistant Coach")
    ]
    
    
    // You'd then call your API here, probably in an init method, or in response to certain actions, and then save the data to `yourModels`.
    struct WeekData: Identifiable {
        let id = UUID()
        let day: String
        let activity: String
        let coach: String
    }
    
    struct CoachContact: Identifiable {
        let id = UUID()
        let coach: String
        let coachRole: String
    }
    
    //Services and Controllers
    let userService : UserService
    
        //Everything User
    @Published var userInformation: UserInformation?
    
    init(userService: UserService) {
        self.userService = userService
    }
    
    func getUserInformation(){
        self.userService.getUserInformation { [weak self] userInfo in
            DispatchQueue.main.async{
                self?.userInformation = userInfo
            }
        }
    }


    

}
