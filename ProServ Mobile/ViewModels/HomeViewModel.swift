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
    
    
    init() {
        // Call your API here and update yourModels
//       APIService.fetchData { (result) in
//            switch result {
//            case .success(let models):
//                self.yourModels = models
//            case .failure(let error):
//                print (error.localizedDescription)
//            }
//        }
    }

    func getUserInformation(){
        let url = URL(string: "https://localhost:5274/api/user/user-information")!
        var request = URLRequest(url: url)
        request.setValue("Bearer \("token")", forHTTPHeaderField: "Authorization")

        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error: \(error)")
            } else if let data = data {
                let str = String(data: data, encoding: .utf8)
                print("Received data:\n\(str ?? "")")
                
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                do {
                    let userInformation = try decoder.decode(UserInformation.self, from: data)
                    print(userInformation)
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            }
        }
        task.resume()

    }
}
