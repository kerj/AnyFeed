//
//  MapSnapshotView.swift
//  iFinesse
//
//  Created by Justin Kerntz on 6/3/25.
//
import SwiftUI
import MapKit

struct RideMapSnapshotView: View {
    @StateObject var snapshotViewModel = RideMapSnapshotViewModel()

    let region: MKCoordinateRegion
    let polyline: String?
    let start: CLLocationCoordinate2D?
    let end: CLLocationCoordinate2D?

    var body: some View {
        Group {
            if let image = snapshotViewModel.snapshotImage {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(height: 150)
                    .clipped()
                    .cornerRadius(10)
            } else {
                Rectangle()
                    .fill(Color.gray.opacity(0.2))
                    .frame(height: 150)
                    .cornerRadius(10)
            }
        }
        .onAppear {
            snapshotViewModel.generateSnapshot(region: region, polyline: polyline, start: start, end: end)
        }
    }
}
