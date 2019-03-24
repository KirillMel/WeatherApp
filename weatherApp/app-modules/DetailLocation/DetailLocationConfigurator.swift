//
//  DetailLocationConfigurator.swift
//  weatherApp
//
//  Created by kirill on 3/24/19.
//  Copyright © 2019 kirill. All rights reserved.
//

import Foundation

class DetailLocationConfigurator: DetailLocationConfiguratorProtocol {
    func configure(with view: DetailLocationViewProtocol) {
        let viewController = view as! DetailLocationViewController
        
        let presenter = DetailLocationPresenter(viewController: viewController)
        let interactor: DetailLocationInteractorProtocol = DetailLocationInteractor(presenter: presenter)
        let router: DetailLocationRouterProtocol = DetailLocationRouter(viewController: viewController)
        
        presenter.interactor = interactor
        presenter.router = router
        viewController.presenter = presenter
    }
}
