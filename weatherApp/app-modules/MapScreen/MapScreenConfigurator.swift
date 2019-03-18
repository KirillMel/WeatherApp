//
//  MapScreenConfigurator.swift
//  weatherApp
//
//  Created by kirill on 3/18/19.
//  Copyright © 2019 kirill. All rights reserved.
//

import Foundation

class MapScreenConfigurator: MapScreenConfiguratorProtocol {
    func configure(with view: MapScreenViewProtocol) {
        let viewController = view as! MapScreenViewController
        
        let presenter = MapScreenPresenter(viewController: viewController)
        let router = MapScreenRouter(viewController: viewController)
        let interactor = MapScreenInteractor(presenter: presenter)
        
        presenter.router = router
        presenter.interactor = interactor
        viewController.presenter = presenter
    }
}
