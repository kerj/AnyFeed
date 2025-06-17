import Foundation

struct AthleteDTO: Decodable {
    let id: Int?
    let username: String?
    let resource_state: Int?
    let firstname: String?
    let lastname: String?
    let city: String?
    let state: String?
    let country: String?
    let sex: String?
    let premium: Bool?
    let created_at: String?
    let updated_at: String?
    let badge_type_id: Int?
    let profile_medium: String?
    let profile: String?
    let friend: String?
    let follower: String?
    let follower_count: Int?
    let friend_count: Int?
    let mutual_friend_count: Int?
    let athlete_type: Int?
    let date_preference: String?
    let measurement_preference: String?
    let ftp: Int?
    let weight: Double?
    let bikes: [BikeDTO]?
    let shoes: [ShoeDTO]?
    // Custom init with defaults
    init(
        id: Int? = nil,
        username: String? = nil,
        resource_state: Int? = nil,
        firstname: String? = nil,
        lastname: String? = nil,
        city: String? = nil,
        state: String? = nil,
        country: String? = nil,
        sex: String? = nil,
        premium: Bool? = nil,
        created_at: String? = nil,
        updated_at: String? = nil,
        badge_type_id: Int? = nil,
        profile_medium: String? = nil,
        profile: String? = nil,
        friend: String? = nil,
        follower: String? = nil,
        follower_count: Int? = nil,
        friend_count: Int? = nil,
        mutual_friend_count: Int? = nil,
        athlete_type: Int? = nil,
        date_preference: String? = nil,
        measurement_preference: String? = nil,
        ftp: Int? = nil,
        weight: Double? = nil,
        bikes: [BikeDTO]? = nil,
        shoes: [ShoeDTO]? = nil
    ) {
        self.id = id
        self.username = username
        self.resource_state = resource_state
        self.firstname = firstname
        self.lastname = lastname
        self.city = city
        self.state = state
        self.country = country
        self.sex = sex
        self.premium = premium
        self.created_at = created_at
        self.updated_at = updated_at
        self.badge_type_id = badge_type_id
        self.profile_medium = profile_medium
        self.profile = profile
        self.friend = friend
        self.follower = follower
        self.follower_count = follower_count
        self.friend_count = friend_count
        self.mutual_friend_count = mutual_friend_count
        self.athlete_type = athlete_type
        self.date_preference = date_preference
        self.measurement_preference = measurement_preference
        self.ftp = ftp
        self.weight = weight
        self.bikes = bikes
        self.shoes = shoes
    }
}

struct BikeDTO: Decodable {
    let id: String?
    let primary: Bool?
    let name: String?
    let resource_state: Int?
    let distance: Double?
}

struct ShoeDTO: Decodable {
    let id: String?
    let primary: Bool?
    let name: String?
    let resource_state: Int?
    let distance: Double?
}

struct Bike {
    let id: String
    let name: String
    let distance: Double
    let isPrimary: Bool
}

struct Shoe {
    let id: String
    let name: String
    let distance: Double
    let isPrimary: Bool
}

enum Gender: String {
    case male = "M"
    case female = "F"
    case other = "O"
    case unspecified

    init(from raw: String?) {
        self = Gender(rawValue: raw ?? "") ?? .unspecified
    }
}

struct Athlete {
    let id: Int
    let username: String
    let firstname: String
    let lastname: String
    let city: String
    let state: String
    let country: String
    let gender: Gender
    let isPremium: Bool
    let createdAt: String
    let updatedAt: String
    let profileURL: URL?
    let followerCount: Int
    let friendCount: Int
    let weight: Double
    let resourceState: Int
    let bikes: [Bike]
    let shoes: [Shoe]

    init(from dto: AthleteDTO) {
        self.id = dto.id.or(-1)
        self.resourceState = dto.resource_state.or(0)
        self.username = dto.username.or("")
        self.firstname = dto.firstname.or("")
        self.lastname = dto.lastname.or("")
        self.city = dto.city.or("")
        self.state = dto.state.or("")
        self.country = dto.country.or("")
        self.gender = Gender(from: dto.sex)
        self.isPremium = dto.premium.or(false)
        self.createdAt = dto.created_at.or("")
        self.updatedAt = dto.updated_at.or("")
        self.profileURL = URL(string: dto.profile.or(""))
        self.followerCount = dto.follower_count.or(0)
        self.friendCount = dto.friend_count.or(0)
        self.weight = dto.weight.or(0)

        self.bikes = (dto.bikes ?? []).map {
            Bike(
                id: $0.id.or(""),
                name: $0.name.or(""),
                distance: $0.distance.or(0),
                isPrimary: $0.primary.or(false)
            )
        }

        self.shoes = (dto.shoes ?? []).map {
            Shoe(
                id: $0.id.or(""),
                name: $0.name.or(""),
                distance: $0.distance.or(0),
                isPrimary: $0.primary.or(false)
            )
        }
    }
}

struct MapData: Decodable {
    let id: String
    let summary_polyline: String?
    let resource_state: Int
}

struct RideDTO: Decodable {
    var athlete: AthleteDTO?
    var map: MapData?

    var resource_state: Int?
    var id: Int?
    var name: String?
    var distance: Double?
    var moving_time: Double?
    var workout_type: Int?
    var start_latlng: [Double]?
    var end_latlng: [Double]?
    var location_city: String?
    var location_state: String?

    var elapsed_time: Double?
    var total_elevation_gain: Double?
    var type: String?
    var sport_type: String?
    var external_id: String?
    var upload_id: Int?
    var start_date: Date?
    var start_date_local: Date?
    var timezone: String?
    var utc_offset: Double?

    var location_country: String?
    var achievement_count: Int?
    var kudos_count: Int?
    var comment_count: Int?
    var athlete_count: Int?
    var photo_count: Int?
    var trainer: Bool?
    var commute: Bool?
    var manual: Bool?
    var `private`: Bool?
    var flagged: Bool?
    var gear_id: String?
    var from_accepted_tag: Bool?
    var average_speed: Double?
    var max_speed: Double?
    var average_cadence: Double?
    var average_watts: Double?
    var weighted_average_watts: Double?
    var kilojoules: Double?
    var device_watts: Bool?
    var has_heartrate: Bool?
    var average_heartrate: Double?
    var max_heartrate: Int?
    var max_watts: Double?
    var pr_count: Int?
    var total_photo_count: Int?
    var has_kudoed: Bool?
    var suffer_score: Int?
}


struct Ride {
    private static let defaultAthlete = AthleteDTO(id: -1, resource_state: 0)
    private static let defaultMap = MapData(id: "", summary_polyline: "", resource_state: 0)
    
    let athlete: Athlete
    let map: MapData

    let resourceState: Int
    let id: Int
    let name: String
    let distance: Double
    let movingTime: Double
    let workoutType: Int
    let startLatlng: [Double]
    let endLatlng: [Double]
    let locationCity: String
    let locationState: String

    let elapsedTime: Double
    let totalElevationGain: Double
    let type: String
    let sportType: String
    let externalId: String
    let uploadId: Int
    let startDate: Date
    let startDateLocal: Date
    let timezone: String
    let utcOffset: Double

    let locationCountry: String
    let achievementCount: Int
    let kudosCount: Int
    let commentCount: Int
    let athleteCount: Int
    let photoCount: Int
    let trainer: Bool
    let commute: Bool
    let manual: Bool
    let isPrivate: Bool
    let flagged: Bool
    let gearId: String
    let fromAcceptedTag: Bool
    let averageSpeed: Double
    let maxSpeed: Double
    let averageCadence: Double
    let averageWatts: Double
    let weightedAverageWatts: Double
    let kilojoules: Double
    let deviceWatts: Bool
    let hasHeartrate: Bool
    let averageHeartrate: Double
    let maxHeartrate: Int
    let maxWatts: Double
    let prCount: Int
    let totalPhotoCount: Int
    let hasKudoed: Bool
    let sufferScore: Int

    init(from dto: RideDTO) {
        self.athlete = Athlete(from: dto.athlete.or(Self.defaultAthlete))
        self.map =
        dto.map.or(Self.defaultMap)

        self.resourceState = dto.resource_state.or(0)
        self.id = dto.id.or(-1)
        self.name = dto.name.or("Untitled Ride")
        self.distance = dto.distance.or(0)
        self.movingTime = dto.moving_time.or(0)
        self.workoutType = dto.workout_type.or(-1)
        self.startLatlng = dto.start_latlng.or([])
        self.endLatlng = dto.end_latlng.or([])
        self.locationCity = dto.location_city.or("")
        self.locationState = dto.location_state.or("")

        self.elapsedTime = dto.elapsed_time.or(0)
        self.totalElevationGain = dto.total_elevation_gain.or(0)
        self.type = dto.type.or("")
        self.sportType = dto.sport_type.or("")
        self.externalId = dto.external_id.or("")
        self.uploadId = dto.upload_id.or(-1)
        self.startDate = dto.start_date.or(Date.distantPast)
        self.startDateLocal = dto.start_date_local.or(Date.distantPast)
        self.timezone = dto.timezone.or("")
        self.utcOffset = dto.utc_offset.or(0)

        self.locationCountry = dto.location_country.or("")
        self.achievementCount = dto.achievement_count.or(0)
        self.kudosCount = dto.kudos_count.or(0)
        self.commentCount = dto.comment_count.or(0)
        self.athleteCount = dto.athlete_count.or(0)
        self.photoCount = dto.photo_count.or(0)
        self.trainer = dto.trainer.or(false)
        self.commute = dto.commute.or(false)
        self.manual = dto.manual.or(false)
        self.isPrivate = dto.`private`.or(false)
        self.flagged = dto.flagged.or(false)
        self.gearId = dto.gear_id.or("")
        self.fromAcceptedTag = dto.from_accepted_tag.or(false)
        self.averageSpeed = dto.average_speed.or(0)
        self.maxSpeed = dto.max_speed.or(0)
        self.averageCadence = dto.average_cadence.or(0)
        self.averageWatts = dto.average_watts.or(0)
        self.weightedAverageWatts = dto.weighted_average_watts.or(0)
        self.kilojoules = dto.kilojoules.or(0)
        self.deviceWatts = dto.device_watts.or(false)
        self.hasHeartrate = dto.has_heartrate.or(false)
        self.averageHeartrate = dto.average_heartrate.or(0)
        self.maxHeartrate = dto.max_heartrate.or(0)
        self.maxWatts = dto.max_watts.or(0)
        self.prCount = dto.pr_count.or(0)
        self.totalPhotoCount = dto.total_photo_count.or(0)
        self.hasKudoed = dto.has_kudoed.or(false)
        self.sufferScore = dto.suffer_score.or(0)
    }
}

let testAthlete: AthleteDTO = AthleteDTO(
    id: 134815,
    resource_state: 1
)
let testMap: MapData = MapData(
    id: "a12345678987654321",
    summary_polyline: nil,
    resource_state: 2
)

let mockRide = RideDTO(
    athlete: testAthlete,
    map: testMap,
    resource_state: 2,
    id: 987_654_321,
    name: "Mock Ride Example",
    distance: 35000.5,
    moving_time: 3600,
    workout_type: 2,
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

func makeRandomRide(index: Int) -> RideDTO {
    let rideId = Int.random(in: 1000_000...9999_999)
    let athlete = AthleteDTO(id: rideId, resource_state: 1)
    let map = MapData(
        id: "map\(rideId)",
        summary_polyline:
            "iz{tGt~skV]zD@fGtClHDhLl@\\fJCjBh@r@m@YnA`@|BrBcD{B|EQjCdFhObAQLt@c@xBcAV[pBoWf\\}i@viAZr@nGAVfKjKKV`@l@xhAkG\\Sb@Xvo@{BjUR~@tBNH`ToBZcBdBiH~DgBpEyBb@mCnGBbC{@hDbAzDnD|Ev@bCSx@mDgBmAx@iEaBqDbA_FN{At@iC[a@ZUtBwC]cEzCcCzC[vFpAhBGpBl@nEvA~B|AnAbA~EtAvB@n@iCe@eCeDyEe@q@v@NpEi@t@uDkG?iFs@YqEnDc@xAKpFuBMkBnDG|BwALcHfDUfDwCUIhEsAOgA_Aq@XeBpDJzEmAfAsAjEkBPJpDkBZiAfAGp@n@rCqA~@YxAhAxEmArBXnE~@jAElBhCpArAvBzJxEtG`GLr@cAXeMkBwFh@HzArB`H`IfNSl@a@CsNkJe@Be@fFiBpCr@tCOzBXlChBxBBn@y@pAqCwBk@TaAfECpLw@]_FwR}CaDi@VS`CaBXYdDTpAbBr@Vn@Ip@{BhCf@zAC`Bv@jFKt@q@EaA}AcE}Cm@RgAnCi@VwAwC}AcAe@t@WrGe@\\{AaBu@oBaBe@y@eA}Ab@qD[oCeCaByC?rA@k@VBxElFhDZfAm@lAlAzATtCfFd@e@VuGl@g@nAf@zAlDd@MrA{Ch@QlGbGh@@e@eKi@sAvBiCLq@]u@{As@QkBT_CvA_@`@iCl@M`DxCrEzRv@XBaL|@wEv@S`CxBh@Q^{@My@}AmBa@mCJqBm@iDbBeCd@oFp@?fN~Ix@OMoAmH_LgBsFU_DxH[lKhBv@UIo@eDwDcIeFaDaAqAqB_CiAQ_CcAsAWiElAmBqAuFNw@`BsAi@mDfAsAhBOGgEfBAtA{EjAm@DiGtBoDnDnARc@]oBLy@tCZX[McBRu@fAKjEmCfBKBcCpBuDnBPDoEf@}B`DqB|@gAj@b@FfF~CbGj@QCmFv@w@|Eh@pC`DxBj@?}@gBoCm@oDuD{Eo@oDD}BoA{BRqFzHuH|C`@r@sCrCJbBq@`JuA~EzA|Bs@nBbBv@QeA{DeD_EaAoDb@sCYyGpBwGhC}BpAqDhBqBnFgBbByE@{K~BqVy@wuARg@lGQYiIH{@ZT[uBHkHhCg@o@w|@jGi@F]P\\rGQYcJNq@wFB_CiB?i@xJ_StUgYj@eBbB{BCaCiAIiFgOVgCxBkFwBhD_@wBXkAsBHa@{EqKc@GiFeCsHAmQ",
        resource_state: 2)

    return RideDTO(
        athlete: athlete,
        map: map,
        resource_state: 2,
        id: rideId,
        name: "Mock Ride #\(index + 1)",
        distance: Double.random(in: 5_000...50_000),
        moving_time: Double.random(in: 600...7200),
        workout_type: nil,
        start_latlng: [45.53, -122.66],
        end_latlng: [45.53, -122.66],
        //    start_latlng: [Double.random(in: 40.0...50.0), Double.random(in: -125.0 ... -120.0)],
        //    end_latlng: [Double.random(in: 40.0...50.0), Double.random(in: -125.0 ... -120.0)],
        location_city: ["Portland", "Seattle", "San Francisco", "Denver"]
            .randomElement(),
        location_state: ["OR", "WA", "CA", "CO"].randomElement(),
        elapsed_time: Double.random(in: 600...7200),
        total_elevation_gain: Double.random(in: 0...2000),
        type: "Ride",
        sport_type: ["Road", "MountainBike", "Hybrid"].randomElement()
            ?? "Road",
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
    overrides: [(inout RideDTO) -> Void] = []
) -> [RideDTO] {
    var rides: [RideDTO] = []

    for i in 0..<count {
        var ride = makeRandomRide(index: i)
        if i < overrides.count {
            overrides[i](&ride)
        }
        rides.append(ride)
    }

    return rides
}
