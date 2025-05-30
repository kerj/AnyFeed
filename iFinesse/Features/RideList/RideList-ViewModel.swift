import Foundation

enum IconColor {
    case gold, silver, bronze
}

extension RideListView {
    @Observable
    class ViewModel {
        var rides: [Ride] = []
        var displayRides: [RideViewModel] {
            rides.map { RideViewModel(ride: $0) }
        }

        func loadRides() {
            // mock data for now
            self.rides = makeMockRides(count: 3)

        }
    }
}

struct RideViewModel: Identifiable {
    private let ride: Ride

    var id: Int { ride.id }
    var name: String { ride.name }

    var kilometers: Double { ride.distance / 1000 }
    var formatted: String { String(format: "%.2f km", kilometers) }

    var durationMinutes: Int {
        ride.moving_time / 60
    }
    var athlete: String {
        "\(ride.athlete.id)"
    }
    var formattedStartDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: ride.start_date_local)
    }

    var totalElevationGain: String {
        "\(ride.total_elevation_gain) m"
    }
    var achievementCount: Int {
        ride.achievement_count
    }

    // This returns tuples of (iconName, color) to use in the view
    var medalIcons: [(String, IconColor)] {
        switch achievementCount {
        case 1:
            return [("medal.fill", .bronze)]
        case 2:
            return [("medal.fill", .silver), ("medal.fill", .bronze)]
        case let x where x >= 3:
            return [
                ("medal.fill", .gold), ("medal.fill", .silver),
                ("medal.fill", .bronze),
            ]
        default:
            return []
        }
    }

    // others?

    init(ride: Ride) {
        self.ride = ride
    }
}
