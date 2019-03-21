//
//  LocationService.swift
//  weatherApp
//
//  Created by kirill on 3/19/19.
//  Copyright © 2019 kirill. All rights reserved.
//

import MapKit

protocol LocationServiceProtocol: class {
    func getLocaction(altitude: Double, longitude: Double, completionHandler: @escaping ((String, String)) -> Void) -> Void
}

class LocationService: LocationServiceProtocol {
    func getLocaction(altitude: Double, longitude: Double, completionHandler: @escaping ((String, String)) -> Void) {
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: altitude, longitude: longitude)
 
        geoCoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in
            var result: (String, String) = ("", "")
            // Place details
            var placeMark: CLPlacemark!
            placeMark = placemarks?[0]
            
            if let country = placeMark.country {
                result.0 = "\(country)"
            }
            
            if let city = placeMark.locality {
                result.1 = "\(city)"
            } else {
                if let locationName = placeMark.name  {
                    result.1 = "\(locationName)"
                }
            }
            completionHandler(result)
        })
    }
}
