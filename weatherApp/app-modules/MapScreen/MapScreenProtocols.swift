//
//  MapScreenProtocols.swift
//  weatherApp
//
//  Created by kirill on 3/18/19.
//  Copyright © 2019 kirill. All rights reserved.
//

import Foundation

protocol MapScreenViewProtocol: BaseModuleViewProtocol {
    func checkAuthorizationStatus() -> Void
    func addAnnotation(title: String, subtitle: String, altitude: Double, longitude: Double) -> Void
    func displayAnnotation() -> Void
}

protocol MapScreenPresenterToViewProtocol: BaseModulePresenterToViewProtocol {
    func setUpModule() -> Void
    func locationDidSelected(altitude: Double, longitude: Double) -> Void
}

protocol MapScreenPresenterToInteractorProtocol: BaseModulePresenterToInteractorProtocol {
    func loadLocationDidSuccessful(data: String) -> Void
    func loadLocationDidFail(error: String) -> Void
}

protocol MapScreenInteractorProtocol: BaseModuleInteractorProtocol {
    func getLocationInfo(altitude: Double, longitude: Double) -> Void
}

protocol MapScreenRouterProtocol: BaseModuleRouterProtocol {
    
}

protocol MapScreenConfiguratorProtocol: BaseModuleConfiguratorProtocol {
    func configure(with view: MapScreenViewProtocol) -> Void
}
