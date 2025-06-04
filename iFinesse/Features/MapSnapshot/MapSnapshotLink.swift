//
//  MapSnapshotLink.swift
//  iFinesse
//
//  Created by Justin Kerntz on 6/3/25.
//

import SwiftUI
import MapKit

struct RideMapSnapshotWithLink: View {
    let region: MKCoordinateRegion
    let polyline: String?
    let start: CLLocationCoordinate2D?
    let end: CLLocationCoordinate2D?

    var body: some View {
        NavigationLink {
            RideMapDetailView(
                region: region,
                polylineString: polyline,
                startCoordinate: start,
                endCoordinate: end
            )
            .navigationTitle("Ride Map")
            .navigationBarTitleDisplayMode(.inline)
        } label: {
            ZStack {
//                Rectangle()
                RideMapSnapshotView(
                    region: region,
                    polyline: polyline,
                    start: start,
                    end: end
                )
            }
            
            .frame(height: 150) // coordinate with mapSnapshotViewModel
            .cornerRadius(10)
        }
        .buttonStyle(PlainButtonStyle())
    }
}
