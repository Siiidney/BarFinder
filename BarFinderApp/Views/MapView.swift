//
//  MapView.swift
//  BarFinder
//
//  Created by Sinan Korcelik on 09/06/2020.
//  Copyright © 2020 Sinan Korcelik. All rights reserved.
//

import Foundation
import SwiftUI
import MapKit

//Class for the map of Exploration Mode
class Coordinator: NSObject, MKMapViewDelegate {
    
    var control: MapContent
    //Initiates the map from the MapKit
    init(_ control: MapContent) {
        self.control = control
    }
    //Displaying the map view
    func mapView(_ mapView: MKMapView, didAdd views: [MKAnnotationView]) {
        
        if let annotationView = views.first {
            if let annotation = annotationView.annotation {
                if annotation is MKUserLocation {
                    //Fetching longitutde and latitude of the users location
                    let region = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
                    mapView.setRegion(region, animated: true)
                    
                }
            }
        }
        
    }
}
//Map contents are displayed in a seperate function, where landmarks and current location are displayed
struct MapContent: UIViewRepresentable {
    
    let landmarks: [SocialSpot]
    //Fetching current location of the user and pushing it to the map view
    func makeUIView(context: Context) -> MKMapView {
        let map = MKMapView()
        map.showsUserLocation = true
        map.delegate = context.coordinator
        return map
    }
    // Location of the user and bars coordinates are retrieved
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    //The view will automatically update frequently whilst still displaying contents
    func updateUIView(_ uiView: MKMapView, context: UIViewRepresentableContext<MapContent>) {
        updateAnnotations(from: uiView)
    }
    //
    private func updateAnnotations(from mapView: MKMapView) {
        mapView.removeAnnotations(mapView.annotations)
        let annotations = self.landmarks.map(SocialSpotMarker.init)
        mapView.addAnnotations(annotations)
    }
    
}

