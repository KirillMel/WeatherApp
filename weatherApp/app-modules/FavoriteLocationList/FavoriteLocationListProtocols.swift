//
//  FavoriteLocationListProtocols.swift
//  weatherApp
//
//  Created by kirill on 3/21/19.
//  Copyright © 2019 kirill. All rights reserved.
//

import Foundation

protocol FavoriteLocationListViewProtocol: BaseModuleViewProtocol {
    func updateTable() -> Void
}

protocol FavoriteLocationListPresenterToViewProtocol: BaseModulePresenterToViewProtocol {
    func setUpModule() -> Void
    func updateLocationsData() -> Void
    func locationDidSelect(id: Int) -> Void
    func locationDeleted(withId id: Int) -> Void
    func getLocationData(forId id: Int) -> (region: String, country: String, weather: String, weatherImage: String)
    func locationsCount() -> Int
}

protocol FavoriteLocationListPresenterToInteractorProtocol: BaseModulePresenterToInteractorProtocol {
    func locationListDidUpdate() -> Void
    func loadDidFail(error: String) -> Void
}

protocol FavoriteLocationListInteractorProtocol: BaseModuleInteractorProtocol {
    func getLocationList() -> Void
    func getLocation(byId id: Int) -> Location
    func updateLocationsData() -> Void
    func getCount() -> Int
    func deleteLocationFromList(byId id: Int) -> Void
}

protocol FavoriteLocationListRouterProtocol: BaseModuleRouterProtocol {
    func moveToDetail(location: Location) -> Void
}

protocol FavoriteLocationListConfiguratorProtocol: BaseModuleConfiguratorProtocol {
    func configure(with view: FavoriteLocationListViewProtocol)
}
