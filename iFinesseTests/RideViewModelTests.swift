//
//  RideViewModelTests.swift
//  iFinesse
//
//  Created by Justin Kerntz on 5/30/25.
//

import XCTest

@testable import iFinesse

final class RideViewModelTests: XCTestCase {

    func testKilometersFormatting() {
        let rides = makeMockRides(
            count: 1,
            overrides: [
                { $0.distance = 10000.0 }
            ])
        
        let ride = rides.map(Ride.init)[0]
        let viewModel = RideViewModel(ride: ride)

        XCTAssertEqual(viewModel.formatted, "10.00 km")
    }

    func testMedalIcons_variousAchievementCounts() {
        let aNegativeRideDTO = makeMockRides(
            count: 1,
            overrides: [
                { $0.achievement_count = -3 }
            ])
        let a0RideDTO = makeMockRides(
            count: 1,
            overrides: [
                { $0.achievement_count = 0 }
            ])

        let a1RideDTO = makeMockRides(
            count: 1,
            overrides: [
                { $0.achievement_count = 1 }
            ])
        let a2RideDTO = makeMockRides(
            count: 1,
            overrides: [
                { $0.achievement_count = 2 }
            ])
        let a3RideDTO = makeMockRides(
            count: 1,
            overrides: [
                { $0.achievement_count = 3 }
            ])
        
        let a1Ride = a1RideDTO.map(Ride.init)[0]
        let bronzeRide = RideViewModel(ride: a1Ride)
        
        XCTAssertEqual(bronzeRide.medalIcons.count, 1)
        XCTAssertEqual(bronzeRide.medalIcons.first?.1, .bronze)

        let a2Ride = a2RideDTO.map(Ride.init)[0]
        let silverBronzeRide = RideViewModel(ride: a2Ride)
        
        XCTAssertEqual(silverBronzeRide.medalIcons.count, 2)
        XCTAssertEqual(silverBronzeRide.medalIcons[0].1, .silver)
        XCTAssertEqual(silverBronzeRide.medalIcons[1].1, .bronze)
        
        let a3Ride = a3RideDTO.map(Ride.init)[0]
        let goldSilverBronzeRide = RideViewModel(ride: a3Ride)
        
        XCTAssertEqual(goldSilverBronzeRide.medalIcons.count, 3)
        XCTAssertEqual(goldSilverBronzeRide.medalIcons[0].1, .gold)
        XCTAssertEqual(goldSilverBronzeRide.medalIcons[1].1, .silver)
        XCTAssertEqual(goldSilverBronzeRide.medalIcons[2].1, .bronze)

        let a0Ride = a0RideDTO.map(Ride.init)[0]
        let zeroRide = RideViewModel(ride: a0Ride)
        XCTAssertTrue(zeroRide.medalIcons.isEmpty)
        
        let aNegativeRide = aNegativeRideDTO.map(Ride.init)[0]
        let negativeRide = RideViewModel(ride: aNegativeRide)
        XCTAssertTrue(negativeRide.medalIcons.isEmpty)
    }

}
