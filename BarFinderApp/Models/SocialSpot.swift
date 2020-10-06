//
//  SocialSpot.swift
//  BarFinder
//
//  Created by Sinan Korcelik on 09/06/2020.
//  Copyright © 2020 Sinan Korcelik. All rights reserved.
//

import Foundation
import MapKit

//Class marking the point of interest (Bars)
struct SocialSpot {
    
    let placemark: MKPlacemark
    
    //Each bar is uniquely identified
    var id: UUID {
        return UUID()
    }
    //Name of bar
    var name: String {
        self.placemark.name ?? ""
    }
    //Type of landmark
    var title: String {
        self.placemark.title ?? ""
    }
    //Coordinates of the point of interest
    var coordinate: CLLocationCoordinate2D {
        self.placemark.coordinate
    }
}
