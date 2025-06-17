//
//  RideService.swift
//  iFinesse
//
//  Created by Justin Kerntz on 6/4/25.
//

import Foundation

class RideService {
    private let baseURL = "https://www.strava.com/api/v3"

    func fetchRides(
        token: String, after: Int = 1_746_404_036, perPage: Int = 100
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
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

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
