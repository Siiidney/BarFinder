//
//  SocialSpotMarker.swift
//  BarFinder
//
//  Created by Sinan Korcelik on 09/06/2020.
//  Copyright © 2020 Sinan Korcelik. All rights reserved.
//

import MapKit
import UIKit
//Class for marking the identified landmarks
final class SocialSpotMarker: NSObject, MKAnnotation {
    let title: String?
    let coordinate: CLLocationCoordinate2D
    //Initiates the landmarks have been identified
    init(landmark: SocialSpot) {
        //Name and current location are assigned from global to local variables
        self.title = landmark.name
        self.coordinate = landmark.coordinate
    }
}
