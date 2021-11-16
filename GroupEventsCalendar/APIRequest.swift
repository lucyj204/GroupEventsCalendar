//
//  APIRequest.swift
//  GroupEventsCalendar
//
//  Created by Lucy Joyce on 16/11/2021.
//

import Foundation

enum APIError: Error {
    case responseProblem
    case decodingProblem
    case encodingProblem
}

struct APIRequest {
    let resourceURL: URL
    
    init(endPoint: String) {
        let resourceString = "http://Lucys-MacBook-Air.local:3000/\(endPoint)"
        guard let resourceURL = URL(string: resourceString) else {fatalError()}
        
        self.resourceURL = resourceURL
    }
    
    func add (_ groupToAdd: Group, completion: @escaping(Result<Group, APIError>) -> Void) {
        do {
            var urlRequest = URLRequest(url: resourceURL)
            urlRequest.httpMethod = "PUT"
            urlRequest.setValue("abc5365731695765183758165253", forHTTPHeaderField: "gec-session-key")
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.httpBody = try JSONEncoder().encode(groupToAdd)
            
            let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200, let jsonData = data else {
                    completion(.failure(.responseProblem))
                    return
                }
                
                do {
                    let groupToAddData = try JSONDecoder().decode(Group.self, from: jsonData)
                    completion(.success(groupToAddData))
                } catch {
                    completion(.failure(.decodingProblem))
                }
            }
            dataTask.resume()
        } catch {
            completion(.failure(.encodingProblem))
        }
    }
}
