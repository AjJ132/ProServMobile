//
//  TeamService.swift
//  ProServ Mobile
//
//  Created by AJ Johnson on 7/23/23.
//

import Foundation

class WorkoutService{
    
    
    
    
    func getWeeksWorkouts(completion: @escaping (Result<[AssignedWorkout], Error>) -> Void) {
        guard let token = self.getToken() else {
            print("Token not found")
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Token not found"])))
            return
        }
        
        let endpoint = "/api/workout/this-weeks-workouts/overview"
        let url = URL(string: ServerURL.baseURL + endpoint)!
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
                    let responseString = String(data: data, encoding: .utf8)
                    //print("JSON Response: \(responseString ?? "No Data")")
                    // Decode example
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    let response = try decoder.decode(AssignedWorkoutsResponse.self, from: data)
                    let assignedWorkouts = response.values
                    print("Got Workouts")
                    completion(.success(assignedWorkouts))
                } catch {
                    print("Error decoding JSON: \(error)")
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
    
    func getWorkoutsInDateRange(startDate: Date, endDate: Date, completion: @escaping (Result<[Workout], Error>) -> Void) {
        guard let token = self.getToken() else {
            print("Token not found")
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Token not found"])))
            return
        }
        
        // Convert dates to ISO8601 format for the URL
        let isoFormatter = DateFormatter.iso8601Full
        let startDateString = isoFormatter.string(from: startDate)
        let endDateString = isoFormatter.string(from: endDate)
        
        let endpoint = "/workout/workouts-by-date-range/\(startDateString)/\(endDateString)"
//        guard let url = URL(string: ServerURL.baseURL + endpoint) else {
//            print("Failed to create URL from string")
//            return
//        }
        var testURl = ServerURL.baseURL + endpoint
        print(testURl)
        let url = URL(string: ServerURL.baseURL + endpoint)!
        var request = URLRequest(url: url)
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            //print(String(data: data!, encoding: .utf8) ?? "Invalid data")

            if let error = error {
                print("Error: \(error)")
                completion(.failure(error))
            } else if let data = data, let httpResponse = response as? HTTPURLResponse {
                switch httpResponse.statusCode {
                case 200:
                    do {
                        let decoder = JSONDecoder()
                        decoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601Full)

                        // Attempt to decode WorkoutResponseJSON first
                        let response = try decoder.decode(WorkoutResponseJSON.self, from: data)
                        let workouts = response.values.map { Workout(from: $0) }
                        print("Got Workouts by date range")
                        completion(.success(workouts))
                    } catch {
                        let decoder = JSONDecoder()
                        do {
                            let messageResponse = try decoder.decode(MessageResponse.self, from: data)
                            print("Information: \(messageResponse.message)")
                            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: messageResponse.message])))
                        } catch {
                            // If both decodings fail, report the error
                            print("Error decoding JSON: \(error)")
                            completion(.failure(error))
                        }
                    }

                default:
                    // Handle other status codes if needed
                    print("Unhandled status code: \(httpResponse.statusCode)")
                    completion(.failure(NSError(domain: "", code: httpResponse.statusCode, userInfo: nil)))
                }
            }
        }
        task.resume()

    }

    

    func getToken() -> String? {
        return KeychainWrapper.standard.string(forKey: "userToken")
    }
    
    struct AssignedWorkoutsResponse: Decodable {
        let values: [AssignedWorkout]

        enum CodingKeys: String, CodingKey {
            case values = "$values"
        }
    }
}
