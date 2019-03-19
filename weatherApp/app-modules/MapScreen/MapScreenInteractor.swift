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
    let locationService: LocationServiceProtocol = LocationService()
    
    private var description: String = ""
    private var temperature: String = ""
    
    required init(presenter: MapScreenPresenterToInteractorProtocol) {
        self.presenter = presenter
    }
    
    func getLocationInfo(altitude: Double, longitude: Double) {
        let group = DispatchGroup()
        group.enter()
        locationService.getLocaction(altitude: altitude, longitude: longitude) { [weak self] result in
            self?.description = result
            group.leave()
        }
        group.enter()
        getTemperature(altitude: altitude, longitude: longitude, completionHandler: { result in
            self.temperature = result
            group.leave()
        })
        
        group.notify(queue: .main) {
            self.sendDataToPresenter()
        }
    }
    
    private func getTemperature(altitude: Double, longitude: Double, completionHandler: @escaping (String) -> Void) {
        completionHandler("+15") //tmp
    }
    
    private func sendDataToPresenter() {
        if (!description.isEmpty && !temperature.isEmpty) {
            presenter?.loadLocationDidSuccessful(description: description, temperature: temperature)
        }
    }
}
