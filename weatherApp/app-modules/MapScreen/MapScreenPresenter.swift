//
//  MapScreenPresenter.swift
//  weatherApp
//
//  Created by kirill on 3/18/19.
//  Copyright © 2019 kirill. All rights reserved.
//

import Foundation

class MapScreenPresenter: MapScreenPresenterToViewProtocol, MapScreenPresenterToInteractorProtocol {
    //MARK: - Viper layers
    weak var viewController: MapScreenViewProtocol?
    var interactor: MapScreenInteractorProtocol?
    var router: MapScreenRouterProtocol?
    
    //MARK: - variables
    var altitude: Double = 0.0
    var longitude: Double = 0.0
    
    required init(viewController: MapScreenViewProtocol) {
        self.viewController = viewController
    }
    
    //MARK: - impelemntation MapScreenPresenterToViewProtocol
    
    func setUpModule() {
        viewController?.checkAuthorizationStatus()
    }
    
    func locationDidSelected(altitude: Double, longitude: Double) {
        self.altitude = checkValue(of: altitude)
        self.longitude = checkValue(of: longitude)
        
        interactor?.getLocationInfo(altitude: altitude, longitude: longitude)
    }
    
    //MARK: - impelemntation MapScreenPresenterToInteractorProtocol
    func loadLocationDidSuccessful(description: String, weather: (Int, String)) {
        let temperature = weather.0
        let weatherDescription = weather.1.capitalizingFirstLetter()
        
        let subtitle = (temperature>0) ? "+\(temperature), \(weatherDescription)" : "\(temperature), \(weatherDescription)"
        viewController?.addAnnotation(title: description, subtitle: subtitle, altitude: altitude, longitude: longitude)
    }
    
    func loadLocationDidFail(error: String) {
        viewController?.showAlert(title: "Notice", message: "Some Error")
    }
    
    //MARK: - helpers methods
    private func checkValue(of point: Double) -> Double {
        return (point>0) ? point : point * (-1)
    }
}
