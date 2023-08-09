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
    let _serviceOrchestrator : ServiceOrchestrator

    
    
    //Everything User
    // User-related properties
    @Published var userInformation: DataState<UserInformation> = .idle {
        didSet {
            switch userInformation {
            case .loaded(let userInfo):
                userFirstName = userInfo.firstName
            default:
                userFirstName = ""
            }
        }
    }
    
    @Published var userTeam: DataState<Team> = .idle {
        didSet {
            switch userTeam {
            case .loaded(let userTeam):
                userTeamName = userTeam.teamName
            default:
                userTeamName = ""
            }
        }
    }
    
    @Published var userWeekWorkouts: DataState<[AssignedWorkout]> = .idle {
        didSet {
            switch userWeekWorkouts {
            case .loaded(let workouts):
                weeksWorkouts = workouts
            default:
                weeksWorkouts = []
            }
        }
    }

    
    //UI variables
    @Published var userFirstName: String = ""
    @Published var userTeamName: String = ""
    @Published var weeksWorkouts: [AssignedWorkout] = []



    
    init() {
        self._serviceOrchestrator = ServiceOrchestrator()
        
        //Get User Information
        getUserInformation()
        
        //Get Team Information
        getUserTeam()
        
        //Get this weeks workouts for the user
        //getThisWeeksWorkouts()
    }
    
    func getUserInformation() {
        self.userInformation = .loading
        self._serviceOrchestrator._userService.getUserInformation() { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let userInfo):
                    self?.userInformation = .loaded(userInfo)
                case .failure(let error):
                    self?.userInformation = .error(error)
                }
            }
        }
    }

    func getUserTeam() {
        self.userTeam = .loading
        self._serviceOrchestrator._teamService.getTeam() { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let team):
                    self?.userTeam = .loaded(team)
                case .failure(let error):
                    self?.userTeam = .error(error)
                }
            }
        }
    }

    func getThisWeeksWorkouts(){
        self.userWeekWorkouts = .loading
        self._serviceOrchestrator._workoutService.getWeeksWorkouts() { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let workouts):
                    self?.userWeekWorkouts = .loaded(workouts)
                case .failure(let error):
                    self?.userWeekWorkouts = .error(error)
                }
            }
        }
    }
    
    
    //Get the day of the week string from Date
    func dayOfWeek(from date: Date) -> String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "EEEE"
            return dateFormatter.string(from: date)
        }




    

}
