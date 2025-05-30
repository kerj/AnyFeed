//
//  RideViewModelTests.swift
//  iFinesse
//
//  Created by Justin Kerntz on 5/30/25.
//

import XCTest

@testable import iFinesse  // replace with your app module name

final class RideViewModelTests: XCTestCase {

    func testKilometersFormatting() {
        let rides = makeMockRides(
            count: 1,
            overrides: [
                { $0.distance = 10000.0 }
            ])
        let viewModel = RideViewModel(ride: rides[0])

        XCTAssertEqual(viewModel.formatted, "10.00 km")
    }

    func testMedalIcons_variousAchievementCounts() {
        let aNegativeRide = makeMockRides(
            count: 1,
            overrides: [
                { $0.achievement_count = -3 }
            ])
        let a0Ride = makeMockRides(
            count: 1,
            overrides: [
                { $0.achievement_count = 0 }
            ])

        let a1Ride = makeMockRides(
            count: 1,
            overrides: [
                { $0.achievement_count = 1 }
            ])
        let a2Ride = makeMockRides(
            count: 1,
            overrides: [
                { $0.achievement_count = 2 }
            ])
        let a3Ride = makeMockRides(
            count: 1,
            overrides: [
                { $0.achievement_count = 3 }
            ])

        let bronzeRide = RideViewModel(ride: a1Ride[0])
        XCTAssertEqual(bronzeRide.medalIcons.count, 1)
        XCTAssertEqual(bronzeRide.medalIcons.first?.1, .bronze)

        let silverBronzeRide = RideViewModel(ride: a2Ride[0])
        XCTAssertEqual(silverBronzeRide.medalIcons.count, 2)
        XCTAssertEqual(silverBronzeRide.medalIcons[0].1, .silver)
        XCTAssertEqual(silverBronzeRide.medalIcons[1].1, .bronze)

        let goldSilverBronzeRide = RideViewModel(ride: a3Ride[0])
        XCTAssertEqual(goldSilverBronzeRide.medalIcons.count, 3)
        XCTAssertEqual(goldSilverBronzeRide.medalIcons[0].1, .gold)
        XCTAssertEqual(goldSilverBronzeRide.medalIcons[1].1, .silver)
        XCTAssertEqual(goldSilverBronzeRide.medalIcons[2].1, .bronze)

        let zeroRide = RideViewModel(ride: a0Ride[0])
        XCTAssertTrue(zeroRide.medalIcons.isEmpty)

        let negativeRide = RideViewModel(ride: aNegativeRide[0])
        XCTAssertTrue(negativeRide.medalIcons.isEmpty)
    }

}
