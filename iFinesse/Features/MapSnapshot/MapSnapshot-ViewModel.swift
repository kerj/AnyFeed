//
//  MapSnapshot-ViewModel.swift
//  iFinesse
//
//  Created by Justin Kerntz on 6/3/25.
//

import MapKit
import Polyline

class RideMapSnapshotViewModel: ObservableObject {
    @Published var snapshotImage: UIImage?

    func generateSnapshot(
        region: MKCoordinateRegion, polyline: String?,
        start: CLLocationCoordinate2D?, end: CLLocationCoordinate2D?
    ) {
        let options = MKMapSnapshotter.Options()
        options.region = region
        options.size = CGSize(width: 300, height: 150)  // Customize as needed
        options.mapType = .standard

        let snapshotter = MKMapSnapshotter(options: options)
        snapshotter.start { snapshot, error in
            guard let snapshot = snapshot, error == nil else { return }

            // Draw overlays (polyline + pins)
            let image = snapshot.image
            let finalImage = UIGraphicsImageRenderer(size: image.size).image {
                context in
                image.draw(at: .zero)

                let cgContext = context.cgContext
                cgContext.setStrokeColor(UIColor.systemBlue.cgColor)
                cgContext.setLineWidth(3.0)

                if let polyline = polyline,
                    let coords = Polyline(encodedPolyline: polyline)
                        .coordinates,
                    !coords.isEmpty
                {
                    let points = coords.map { snapshot.point(for: $0) }
                    for i in 1..<points.count {
                        cgContext.move(to: points[i - 1])
                        cgContext.addLine(to: points[i])
                        cgContext.strokePath()
                    }
                }

                func drawPin(
                    at coordinate: CLLocationCoordinate2D, color: UIColor
                ) {
                    let point = snapshot.point(for: coordinate)
                    let pinSize: CGFloat = 8
                    let pinRect = CGRect(
                        x: point.x - pinSize / 2, y: point.y - pinSize / 2,
                        width: pinSize, height: pinSize)
                    cgContext.setFillColor(color.cgColor)
                    cgContext.fillEllipse(in: pinRect)
                }

                if let start = start {
                    drawPin(at: start, color: .green)
                }
                if let end = end {
                    drawPin(at: end, color: .red)
                }
            }

            DispatchQueue.main.async {
                self.snapshotImage = finalImage
            }
        }
    }
}
