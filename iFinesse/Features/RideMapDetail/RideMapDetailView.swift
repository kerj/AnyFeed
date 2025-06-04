import MapKit
import Polyline
//
//  RideMapDetailView.swift
//  iFinesse
//
//  Created by Justin Kerntz on 6/3/25.
//
import SwiftUI

struct RideMapDetailView: UIViewRepresentable {
    let region: MKCoordinateRegion
    let polylineString: String?
    let startCoordinate: CLLocationCoordinate2D?
    let endCoordinate: CLLocationCoordinate2D?

    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        mapView.setRegion(region, animated: false)
        mapView.isScrollEnabled = true
        mapView.isZoomEnabled = true
        mapView.isUserInteractionEnabled = true

        if let polylineString = polylineString {
            let polyline = Polyline(encodedPolyline: polylineString)
            if let coordinates = polyline.coordinates, !coordinates.isEmpty {
                let polylineOverlay = MKPolyline(
                    coordinates: coordinates, count: coordinates.count)
                mapView.addOverlay(polylineOverlay)
            }

        }

        if let start = startCoordinate {
            let pin = MKPointAnnotation()
            pin.coordinate = start
            pin.title = "Start"
            mapView.addAnnotation(pin)
        }

        if let finish = endCoordinate {
            let pin = MKPointAnnotation()
            pin.coordinate = finish
            pin.title = "Finish"
            mapView.addAnnotation(pin)
        }

        return mapView
    }

    func updateUIView(_ mapView: MKMapView, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator()
    }

    class Coordinator: NSObject, MKMapViewDelegate {
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay)
            -> MKOverlayRenderer
        {
            if let polyline = overlay as? MKPolyline {
                let renderer = MKPolylineRenderer(polyline: polyline)
                renderer.strokeColor = .systemBlue
                renderer.lineWidth = 3
                return renderer
            }
            return MKOverlayRenderer(overlay: overlay)
        }
    }
}
