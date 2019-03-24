//
//  FavoriteLocationListPresenter.swift
//  weatherApp
//
//  Created by kirill on 3/21/19.
//  Copyright © 2019 kirill. All rights reserved.
//

import Foundation

class FavoriteLocationListPresenter: FavoriteLocationListPresenterToViewProtocol, FavoriteLocationListPresenterToInteractorProtocol {
    //MARK: - Viper layers
    weak var viewController: FavoriteLocationListViewProtocol!
    var interactor: FavoriteLocationListInteractorProtocol!
    var router: FavoriteLocationListRouterProtocol!
    
    required init(viewController: FavoriteLocationListViewProtocol) {
        self.viewController = viewController
    }
    
    //MARK: - implementation FavoriteLocationListPresenterToViewProtocol
    func locationsCount() -> Int {
        return interactor.getCount()
    }
    
    func setUpModule() {
        interactor.getLocationList()
    }
    
    func updateLocationsData() {
        interactor.updateLocationsData()
    }
    
    func locationDidSelect(id: Int) {
        let location = interactor.getLocation(byId: id)
        router.moveToDetail(location: location)
    }
    
    func locationDeleted(withId id: Int) {
        interactor.deleteLocationFromList(byId: id)
    }
    
    func getLocationData(forId id: Int) -> (region: String, country: String, weather: String, weatherImage: String){
        let location = interactor.getLocation(byId: id)
        let temperature = Int(truncatingIfNeeded: (location.weather?.temperature)!)
        var weatherDetail = location.weather?.detail ?? " "
        let image = ImageSwitchHelper.shared.switchImage(description: weatherDetail)
        weatherDetail.capitalizeFirstLetter()
        
        var  weather = "\(temperature), \(weatherDetail)"
        weather = (temperature > 0) ? "+\(weather)" : weather
        
        return (region: location.name ?? "region", country: location.country ?? "country", weather: weather, weatherImage: image)
    }
    
    //MARK: implementation FavoriteLocationListRouterProtocol
    func locationListDidUpdate() {
        viewController.updateTable()
    }
    
    func loadDidFail(error: String) {
        viewController.showAlert(title: "Notice", message: error)
    }
}
