//
//  DetailLocationInteractor.swift
//  weatherApp
//
//  Created by kirill on 3/24/19.
//  Copyright © 2019 kirill. All rights reserved.
//

import Foundation

class DetailLocationInteractor: DetailLocationInteractorProtocol {
    //MARK: - Viper layers
    weak var presenter: DetailLocationPresenterToInteractorProtocol!
    //MARK: - services
    private let remoteService = ServerService()
    private let localStorage: LocalSorageProtocol = LocalStorage()
    //MARK: - Entities, variables
    private weak var location: Location?
    private var weatherDetailList: [DetailedWeather] = [DetailedWeather]()
    
    required init(presenter: DetailLocationPresenterToInteractorProtocol) {
        self.presenter = presenter
    }
    
    //MARK: - implementation DetailLocationInteractorProtocol
    func setSelectedlocation(_ location: Location) {
        self.location = location
    }
    
    func getData() -> Location {
        return location!
    }
    
    func getDetaliedWeather(byId id: Int) -> DetailedWeather? {
        return weatherDetailList[id]
    }
    
    func getCount() -> Int {
        return weatherDetailList.count
    }
    
    func loadWeatherData() {
        remoteService.setUpService(route: .detailedWeather, success: { result in
            guard let result = result as? [DetailedWeather] else { return }
            self.weatherDetailList = result
            self.location?.weather?.detail = result[0].description
            self.location?.weather?.temperature = Int64(truncatingIfNeeded: result[0].temperature ?? 0)
            self.presenter.dataLoadingDidSuccesful()
            self.localStorage.updateItems()
        }) { error in
            
        }
        remoteService.getWeather(latitude: (location?.latitude)!, longitute: (location?.longitude)!)
    }
}
