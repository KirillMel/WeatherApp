//
//  MapScreenInteractor.swift
//  weatherApp
//
//  Created by kirill on 3/18/19.
//  Copyright © 2019 kirill. All rights reserved.
//

import Foundation
import MapKit

class MapScreenInteractor: MapScreenInteractorProtocol {
    
    weak var presenter: MapScreenPresenterToInteractorProtocol?
    
    required init(presenter: MapScreenPresenterToInteractorProtocol) {
        self.presenter = presenter
    }
    
    func getLocationInfo(altitude: Double, longitude: Double) {
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: altitude, longitude: longitude)
        //tmp, preparation for service
        geoCoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in
            var result: String = ""
            // Place details
            var placeMark: CLPlacemark!
            placeMark = placemarks?[0]
            
            if let country = placeMark.country {
                result = "\(country), "
            }
            
            if let city = placeMark.locality {
                result += city
            } else {
                if let locationName = placeMark.name  {
                    result += locationName
                }
            }
            
            self.presenter?.loadLocationDidSuccessful(data: result)
        })
    }
}
