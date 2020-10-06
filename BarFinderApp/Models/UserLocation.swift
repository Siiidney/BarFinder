//
//  UserLocation.swift
//  BarFinder
//
//  Created by Sinan Korcelik on 09/06/2020.
//  Copyright © 2020 Sinan Korcelik. All rights reserved.
//

import Foundation
import MapKit

//Class to identify the specific user using the application
class UserLocation: NSObject, ObservableObject {
    
    private let locationManager = CLLocationManager()
    @Published var location: CLLocation? = nil
    
    override init() {
        
        //Initiating the current users location, ensuring smooth start up for current location
        //and privacy settings are met
        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.distanceFilter = kCLDistanceFilterNone
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        
    }
    
}

extension UserLocation: CLLocationManagerDelegate {
    //Locating the user on the map
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print(status)
    }
    //Dynamically update the users location
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
            return
        }
        
        self.location = location
    }
    
}
