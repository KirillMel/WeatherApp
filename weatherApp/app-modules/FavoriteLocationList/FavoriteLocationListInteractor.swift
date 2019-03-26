//
//  FavoriteLocationListInteractor.swift
//  weatherApp
//
//  Created by kirill on 3/21/19.
//  Copyright © 2019 kirill. All rights reserved.
//

import Foundation

class FavoriteLocationListInteractor: FavoriteLocationListInteractorProtocol {
    weak var presenter: FavoriteLocationListPresenterToInteractorProtocol!
    
    private let localStorage: LocalSorageProtocol = LocalStorage()
    private let weatherService = ServerService()
    
    private var locationList: [Location]
    
    required init(presenter: FavoriteLocationListPresenterToInteractorProtocol) {
        self.presenter = presenter
        
        locationList = [Location]()
    }
    
    func getLocationList() {
        locationList = localStorage.loadData()
        
        presenter.locationListDidUpdate()
    }
    
    func updateLocationsData() {
        getLocationList()
        
        let group = DispatchGroup()
        for location in locationList {
            group.enter()
            weatherService.setUpService(route: .defaultWeather, success: { result in
                guard let result = result as? (temperature: Int, description: String) else { return }
                
                location.weather?.temperature = Int64(truncatingIfNeeded: result.temperature)
                location.weather?.detail = result.description
                
                self.localStorage.updateItems()
                
                group.leave()
            }) { error in
                self.presenter.loadDidFail(error: error ?? "Load date did fail")
            }
            
            let timestamp = DateFormatter.localizedString(from: Date(), dateStyle: .medium, timeStyle: .short)
            
            UserDefaults.standard.set("Updated : \(timestamp)", forKey: "lastUpdates")
            
            weatherService.getWeather(latitude: location.latitude, longitute: location.longitude)
        }
        group.notify(queue: .main) {
            self.presenter.locationListDidUpdate()
        }
    }
    
    func deleteLocationFromList(byId id: Int) {
        try? localStorage.deleteItem(withName: locationList[id].name!)
        
        locationList.remove(at: id)
    }
    
    func getLocation(byId id: Int) -> Location {
        return locationList[id]
    }
    
    func getCount() -> Int {
        return locationList.count
    }
    
}
