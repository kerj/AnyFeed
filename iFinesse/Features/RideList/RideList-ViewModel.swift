import Foundation
import CoreLocation
import MapKit
import Polyline

enum IconColor {
    case gold, silver, bronze
}

func boundingRegion(
    from polylineString: String,
    including start: CLLocationCoordinate2D?,
    and end: CLLocationCoordinate2D?,
    paddingFactor: Double = 1.3
) -> MKCoordinateRegion? {
    // Decode polyline into coordinates
    let polyline = Polyline(encodedPolyline: polylineString)
    guard let polylineCoords = polyline.coordinates, !polylineCoords.isEmpty else {
        return nil
    }

    // Find min/max lat/lon
    let lats = polylineCoords.map { $0.latitude }
    let lons = polylineCoords.map { $0.longitude }

    guard let minLat = lats.min(),
          let maxLat = lats.max(),
          let minLon = lons.min(),
          let maxLon = lons.max()
    else { return nil }

    // Compute center and span
    let centerLat = (minLat + maxLat) / 2
    let centerLon = (minLon + maxLon) / 2
    let latDelta = (maxLat - minLat) * paddingFactor
    let lonDelta = (maxLon - minLon) * paddingFactor

    let center = CLLocationCoordinate2D(latitude: centerLat, longitude: centerLon)
    let span = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: lonDelta)

    return MKCoordinateRegion(center: center, span: span)
}

extension RideListView {
    class ViewModel: ObservableObject {
        @Published var rides: [Ride] = []
        @Published var errorMessage: String?
        

        init(rides: [Ride], errorMessage: String? = nil) {
            self.rides = rides
            self.errorMessage = errorMessage
        }

        var displayRides: [RideViewModel] {
            rides.map { RideViewModel(ride: $0) }
        }
        
    }
}

// TODO: This needs revisited
struct RideViewModel: Identifiable {
    private let ride: Ride
    
    private func coordinate(from array: [Double]?) -> CLLocationCoordinate2D? {
        guard let array = array, array.count == 2 else { return nil }
        return CLLocationCoordinate2D(latitude: array[0], longitude: array[1])
    }

    var id: Int { ride.id }
    var name: String { ride.name }

    var kilometers: Double { ride.distance / 1000 }
    var formatted: String { String(format: "%.2f km", kilometers) }

    var durationMinutes: Double {
        ride.movingTime / 60
    }
    var athlete: String {
        "\(ride.athlete.id)"
    }
    var formattedStartDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: ride.startDateLocal)
    }
    

    var startCoordinate: CLLocationCoordinate2D? {
        coordinate(from: ride.startLatlng)
    }

    var endCoordinate: CLLocationCoordinate2D? {
        coordinate(from: ride.endLatlng)
    }
    
    var mapCenter: MKCoordinateRegion? {
        guard let polyline = ride.map.summary_polyline else { return nil }
        return boundingRegion(from: polyline, including: startCoordinate, and: endCoordinate)
    }
    
    var totalElevationGain: String {
        "\(ride.totalElevationGain) m"
    }
    var achievementCount: Int {
        ride.achievementCount
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
    
    var map: MapData {
        ride.map
    }

    // others?

    init(ride: Ride) {
        self.ride = ride
    }
}
