//
//  DetailLocationProtocols.swift
//  weatherApp
//
//  Created by kirill on 3/24/19.
//  Copyright © 2019 kirill. All rights reserved.
//

import Foundation

protocol DetailLocationViewProtocol: BaseModuleViewProtocol {
    func updateView(mainDescription: (temperature: String, description: String, image: String)) -> Void
    func updateView(withTitle title: String) -> Void
    func updateTable() -> Void
}

protocol DetailLocationModuleLoader: class {
    var moduleInput: DetailLocationModuleInputProtocol {get}
    
    func createModule()
}

protocol DetailLocationModuleInputProtocol: class {
    func setUpWith(location: Location) -> Void
}

protocol DetailLocationPresenterToViewProtocol: BaseModulePresenterToViewProtocol {
    func setUpViewWithData() -> Void
    func getDetaliedWeather(byId id: Int) -> (description: String, time: String, image: String)
    func getCount() -> Int
}

protocol DetailLocationPresenterToInteractorProtocol: BaseModulePresenterToInteractorProtocol {
    func dataLoadingDidSuccesful() -> Void
}

protocol DetailLocationInteractorProtocol: BaseModuleInteractorProtocol {
    func setSelectedlocation(_ location: Location) -> Void
    func getDetaliedWeather(byId id: Int) -> DetailedWeather?
    func getData() -> Location
    func getCount() -> Int
    func loadWeatherData() -> Void
}

protocol DetailLocationRouterProtocol: BaseModuleRouterProtocol {
    
}

protocol DetailLocationConfiguratorProtocol: BaseModuleConfiguratorProtocol {
    func configure(with view: DetailLocationViewProtocol) -> Void
}
