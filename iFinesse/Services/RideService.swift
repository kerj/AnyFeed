//
//  RideService.swift
//  iFinesse
//
//  Created by Justin Kerntz on 6/4/25.
//

import Foundation

class RideService {
    static let shared = RideService()
    private init() {}
    private var authToken: String?
    private let baseURL = "https://www.strava.com/api/v3"
    
    func setAuthToken(token: String) {
        authToken = token
    }

    


    func getZones() async throws -> Zones {
        guard let url = URL(string: "\(baseURL)/athlete/zones") else {
            throw NetworkError.invalidURL
        }

        var request = URLRequest(url: url)
        request.setValue("Bearer \(authToken ?? "")", forHTTPHeaderField: "Authorization")

        let (data, _) = try await URLSession.shared.data(for: request)

//        if let jsonString = String(data: data, encoding: .utf8) {
//            print("Response JSON: \(jsonString)")
//        }

        let dto = try JSONDecoder().decode(ZonesDTO.self, from: data)
        let zones = Zones(dto: dto)
     
        return zones
    }

    func getProfile(
        athleteId: Int
    ) async throws -> Totals {

        guard
            let url = URL(
                string:
                    "\(baseURL)/athletes/\(athleteId)/stats"
            )
        else {
            throw NetworkError.invalidURL
        }

        var request = URLRequest(url: url)
        request.setValue("Bearer \(authToken ?? "")", forHTTPHeaderField: "Authorization")

        let (data, _) = try await URLSession.shared.data(for: request)
        
        // if let jsonString = String(data: data, encoding: .utf8) {
        //     print("Response JSON: \(jsonString)")
        // }

        let totalsDTO = try JSONDecoder().decode(TotalsDTO.self, from: data)
        let totals = Totals(dto: totalsDTO)

        return totals
    }

    func fetchRides(
        after: Int = 1_746_404_036, perPage: Int = 100
    ) async throws -> [Ride] {

        guard
            let url = URL(
                string:
                    "\(baseURL)/athlete/activities?after=\(after)&per_page=\(perPage)"
            )
        else {
            throw NetworkError.invalidURL
        }

        var request = URLRequest(url: url)
        request.setValue("Bearer \(authToken ?? "")", forHTTPHeaderField: "Authorization")

        let (data, _) = try await URLSession.shared.data(for: request)

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601

        let decoded = try decoder.decode([RideDTO].self, from: data)
        let rides = decoded.map(Ride.init)

        return rides

    }

    enum NetworkError: Error {
        case invalidURL
        case noData
    }
}
