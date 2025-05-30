import Foundation

struct Athlete: Decodable {
  let id: Int
  let resource_state: Int
}

struct MapData: Decodable {
  let id: String
  let summary_polyline: String?
  let resource_state: Int
}

struct Ride: Decodable {
  var athlete: Athlete
  var map: MapData

  var resource_state: Int
  var id: Int
  var name: String
  var distance: Double
  var moving_time: Int
  var workout_type: String?
  var start_latlng: [Double]?
  var end_latlng: [Double]?
  var location_city: String?
  var location_state: String?

  var elapsed_time: Int
  var total_elevation_gain: Int
  var type: String
  var sport_type: String
  var external_id: String
  var upload_id: Int
  var start_date: Date
  var start_date_local: Date
  var timezone: String
  var utc_offset: Int

  var location_country: String
  var achievement_count: Int
  var kudos_count: Int
  var comment_count: Int
  var athlete_count: Int
  var photo_count: Int
  var trainer: Bool
  var commute: Bool
  var manual: Bool
  var `private`: Bool
  var flagged: Bool
  var gear_id: String
  var from_accepted_tag: Bool
  var average_speed: Double
  var max_speed: Double
  var average_cadence: Double
  var average_watts: Double
  var weighted_average_watts: Double
  var kilojoules: Double
  var device_watts: Bool
  var has_heartrate: Bool
  var average_heartrate: Double
  var max_heartrate: Int
  var max_watts: Double
  var pr_count: Int
  var total_photo_count: Int
  var has_kudoed: Bool
  var suffer_score: Int
}

let testAthlete: Athlete = Athlete(
  id: 134815,
  resource_state: 1
)
let testMap: MapData = MapData(
  id: "a12345678987654321",
  summary_polyline: nil,
  resource_state: 2
)

let mockRide = Ride(
  athlete: testAthlete,
  map: testMap,
  resource_state: 2,
  id: 987_654_321,
  name: "Mock Ride Example",
  distance: 35000.5,
  moving_time: 3600,
  workout_type: "Endurance",
  start_latlng: [45.53, -122.66],
  end_latlng: [45.52, -122.67],
  location_city: "Portland",
  location_state: "Oregon",
  elapsed_time: 4000,
  total_elevation_gain: 500,
  type: "Ride",
  sport_type: "MountainBikeRide",
  external_id: "external_123",
  upload_id: 111_222_333,
  start_date: ISO8601DateFormatter().date(from: "2023-08-01T14:30:00Z")!,
  start_date_local: ISO8601DateFormatter().date(
    from: "2023-08-01T07:30:00Z")!,
  timezone: "(GMT-08:00) America/Los_Angeles",
  utc_offset: -28800,
  location_country: "United States",
  achievement_count: 5,
  kudos_count: 10,
  comment_count: 2,
  athlete_count: 1,
  photo_count: 0,
  trainer: false,
  commute: false,
  manual: false,
  private: false,
  flagged: false,
  gear_id: "g12345",
  from_accepted_tag: false,
  average_speed: 9.7,
  max_speed: 15.4,
  average_cadence: 80.0,
  average_watts: 200.5,
  weighted_average_watts: 215.0,
  kilojoules: 720.0,
  device_watts: true,
  has_heartrate: true,
  average_heartrate: 145.3,
  max_heartrate: 178,
  max_watts: 400.0,
  pr_count: 2,
  total_photo_count: 1,
  has_kudoed: false,
  suffer_score: 85
)

func makeRandomRide(index: Int) -> Ride {
  let rideId = Int.random(in: 1000_000...9999_999)
  let athlete = Athlete(id: rideId, resource_state: 1)
  let map = MapData(id: "map\(rideId)", summary_polyline: nil, resource_state: 2)

  return Ride(
    athlete: athlete,
    map: map,
    resource_state: 2,
    id: rideId,
    name: "Mock Ride #\(index + 1)",
    distance: Double.random(in: 5_000...50_000),
    moving_time: Int.random(in: 600...7200),
    workout_type: nil,
    start_latlng: [Double.random(in: 40.0...50.0), Double.random(in: -125.0 ... -120.0)],
    end_latlng: [Double.random(in: 40.0...50.0), Double.random(in: -125.0 ... -120.0)],
    location_city: ["Portland", "Seattle", "San Francisco", "Denver"].randomElement(),
    location_state: ["OR", "WA", "CA", "CO"].randomElement(),
    elapsed_time: Int.random(in: 600...7200),
    total_elevation_gain: Int.random(in: 0...2000),
    type: "Ride",
    sport_type: ["Road", "MountainBike", "Hybrid"].randomElement() ?? "Road",
    external_id: "ext_\(rideId)",
    upload_id: Int.random(in: 1_000_000_000...9_999_999_999),
    start_date: Date(),
    start_date_local: Date(),
    timezone: "GMT-08:00",
    utc_offset: -28800,
    location_country: "United States",
    achievement_count: Int.random(in: 0...5),
    kudos_count: Int.random(in: 0...20),
    comment_count: Int.random(in: 0...10),
    athlete_count: 1,
    photo_count: Int.random(in: 0...5),
    trainer: Bool.random(),
    commute: Bool.random(),
    manual: Bool.random(),
    private: Bool.random(),
    flagged: Bool.random(),
    gear_id: "gear\(rideId)",
    from_accepted_tag: Bool.random(),
    average_speed: Double.random(in: 4.0...15.0),
    max_speed: Double.random(in: 10.0...30.0),
    average_cadence: Double.random(in: 60.0...100.0),
    average_watts: Double.random(in: 100.0...300.0),
    weighted_average_watts: Double.random(in: 150.0...350.0),
    kilojoules: Double.random(in: 200.0...1000.0),
    device_watts: Bool.random(),
    has_heartrate: Bool.random(),
    average_heartrate: Double.random(in: 120.0...180.0),
    max_heartrate: Int.random(in: 150...200),
    max_watts: Double.random(in: 350.0...600.0),
    pr_count: Int.random(in: 0...3),
    total_photo_count: Int.random(in: 0...10),
    has_kudoed: Bool.random(),
    suffer_score: Int.random(in: 0...100)
  )
}

func makeMockRides(
  count: Int,
  overrides: [(inout Ride) -> Void] = []
) -> [Ride] {
  var rides: [Ride] = []

  for i in 0..<count {
    var ride = makeRandomRide(index: i)
    if i < overrides.count {
      overrides[i](&ride)
    }
    rides.append(ride)
  }

  return rides
}
