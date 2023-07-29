//
//  UserService.swift
//  ProServ Mobile
//
//  Created by AJ Johnson on 7/23/23.
//

import Foundation

class UserService {
    
    func getUserInformation(completion: @escaping (Result<UserInformation, Error>) -> Void) {
        guard let token = self.getToken() else {
            print("Token not found")
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Token not found"])))
            return
        }
        
        let url = URL(string: "http://localhost:5274/api/user/user-information")!
        var request = URLRequest(url: url)
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error: \(error)")
                completion(.failure(error))
            } else if let data = data {
                //TEMP FIX Datetimes need to be DateTimeOffset at UTC values
                let dateFormatter = DateFormatter()
                dateFormatter.locale = Locale(identifier: "en_US_POSIX")
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
                dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)

                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .formatted(dateFormatter)

                do {
                    let userInfo = try decoder.decode(UserInformation.self, from: data)
                    completion(.success(userInfo))
                } catch {
                    print("Error decoding JSON: \(error)")
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }



    func getToken() -> String? {
        return KeychainWrapper.standard.string(forKey: "userToken")
    }
}
