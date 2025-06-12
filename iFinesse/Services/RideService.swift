//
//  RideService.swift
//  iFinesse
//
//  Created by Justin Kerntz on 6/4/25.
//

import Foundation

class RideService {
    private let baseURL = "http://127.0.0.1:5266"

    func fetchRides(completion: @escaping (Result<[Ride], Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)/auth/strava/login") else {
            completion(.failure(NetworkError.invalidURL))
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }

            do {
//                
//                if let jsonStr = String(data: data, encoding: .utf8) {
//                    print(jsonStr)
//                }
//                
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                
                let decoded = try decoder.decode([RideDTO].self, from: data)
                let rides = decoded.map(Ride.init)
               
                completion(.success(rides))
            } catch {
                print("Decode Fail", error)
                completion(.failure(error))
            }
        }.resume()
    }

    enum NetworkError: Error {
        case invalidURL
        case noData
    }
}
