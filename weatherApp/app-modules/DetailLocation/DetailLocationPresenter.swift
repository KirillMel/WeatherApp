//
//  DetailLocationPresenter.swift
//  weatherApp
//
//  Created by kirill on 3/24/19.
//  Copyright © 2019 kirill. All rights reserved.
//

import Foundation

class DetailLocationPresenter: DetailLocationPresenterToViewProtocol, DetailLocationPresenterToInteractorProtocol {
    //MARK: - Viper layers
    weak var viewController: DetailLocationViewProtocol!
    var interactor: DetailLocationInteractorProtocol!
    var router: DetailLocationRouterProtocol!
    
    required init(viewController: DetailLocationViewProtocol) {
        self.viewController = viewController
    }

    //MARK: - impementation DetailLocationPresenterToViewProtocol
    func updateView(withTitle title: String) {
        self.viewController.updateView(withTitle: title)
    }
    
    func setUpViewWithData() {
        let location = interactor.getData()
        let temperature = Int(truncatingIfNeeded: (location.weather?.temperature)!)
        var description = location.weather?.detail ?? ""
        description.capitalizeFirstLetter()
        let image = ImageSwitchHelper.shared.switchImage(description: description)
        
        self.viewController.updateView(mainDescription: (temperature: temperature > 0 ? "+\(temperature)°C" : "\(temperature)°C", description: description, image: image))
    }
    
    func getDetaliedWeather(byId id: Int) -> (description: String, time: String, image: String) {
        let weather = interactor.getDetaliedWeather(byId: id)
        var time = weather?.time ?? ""
        time = String(time.replacingOccurrences(of: "2019-", with: "").dropLast(3))
        let image = ImageSwitchHelper.shared.switchImage(description: weather?.description ?? "")
        let temperature = (weather?.temperature)! > 0 ? "+\((weather?.temperature)!)°C" : "\((weather?.temperature)!)°C"
        var description = "\(weather?.description ?? ""), \(temperature)"
        description.capitalizeFirstLetter()
        
        return (description, time, image)
    }
    
    func getCount() -> Int {
        return interactor.getCount()
    }
    
    //MARK: - impementation DetailLocationPresenterToInteractorProtocol
    func dataLoadingDidSuccesful() {
        setUpViewWithData()
        viewController.updateTable()
    }
}

extension DetailLocationPresenter: DetailLocationModuleInputProtocol {
    func setUpWith(location: Location) {
        interactor.setSelectedlocation(location)
        interactor.loadWeatherData()
        
        self.viewController.updateView(withTitle: location.name ?? " ")
    }
}
