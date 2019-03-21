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
    let temperatureService = ServerTemperatureService()
    let localStorage: LocalSorageProtocol = LocalStorage()
    
    private var description: (country: String, region: String) = ("", "")
    private var temperature: (celsium: Int, detail: String) = (0, "")
    let group = DispatchGroup()
    
    required init(presenter: MapScreenPresenterToInteractorProtocol) {
        self.presenter = presenter
        
        self.temperatureService.setUpService(success: { [weak self] result in
            self?.temperature = result!
            self?.group.leave()
        }) { [weak self] error in
            self?.presenter?.loadLocationDidFail(error: error ?? "Fail when loading data")
        }
    }
    
    func getLocationInfo(altitude: Double, longitude: Double) {
    
        group.enter()
        locationService.getLocaction(altitude: altitude, longitude: longitude) { [weak self] result in
            self?.description = result
           self?.group.leave()
        }
        group.enter()
        getTemperature(altitude: altitude, longitude: longitude)
        
        group.notify(queue: .main) {
            self.sendDataToPresenter()
        }
    }
    
    func saveCurrentLocation(altitude: Double, longitude: Double)  {
        localStorage.saveItem(altitude, longitude, description, temperature.detail, temperature.celsium)
    }
    
    func removeCurrentLocation() {
        try? localStorage.deleteItem(withName: description.region)
    }
    
    private func getTemperature(altitude: Double, longitude: Double) {
        temperatureService.getTemperatur(latitude: altitude, longitute: longitude)
    }
    
    private func sendDataToPresenter() {
        if (!description.region.isEmpty && !temperature.detail.isEmpty) {
            presenter?.loadLocationDidSuccessful(description: description, weather: temperature)
        }
    }
}
