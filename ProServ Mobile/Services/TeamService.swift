//
//  TeamService.swift
//  ProServ Mobile
//
//  Created by AJ Johnson on 7/23/23.
//

import Foundation

class TeamService{
    
    private var teamID : Int?
    
    func setTeam(teamID : Int){
        self.teamID = teamID
    }
    
    func getTeamName(){
        
    }
    
    func getTeam(completion: @escaping (Team?) -> Void) {
        guard let token = self.getToken() else {
            print("Token not found")
            completion(nil)
            return
        }
        
        //Ensure teamID is set
        if(teamID == nil){
            completion(nil)
            return
        }
        
        let url = URL(string: "http://localhost:5274/api/team/team")!
        var request = URLRequest(url: url)
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error: \(error)")
                completion(nil)
            } else if let data = data {
                //TEMP FIX Datetimes need to be DateTimeOffset at UTC values
                let dateFormatter = DateFormatter()
                dateFormatter.locale = Locale(identifier: "en_US_POSIX")
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
                dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)

                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .formatted(dateFormatter)

                do {
                    let userInformation = try decoder.decode(Team.self, from: data)
                    completion(userInformation)
                } catch {
                    print("Error decoding JSON: \(error)")
                    completion(nil)
                }
            }
        }
        task.resume()
    }

    func getToken() -> String? {
        return KeychainWrapper.standard.string(forKey: "userToken")
    }

}
