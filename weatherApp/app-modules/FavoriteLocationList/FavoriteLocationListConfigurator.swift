//
//  FavoriteLocationListConfigurator.swift
//  weatherApp
//
//  Created by kirill on 3/21/19.
//  Copyright © 2019 kirill. All rights reserved.
//

import Foundation

class FavoriteLocationListConfigurator: FavoriteLocationListConfiguratorProtocol {
    func configure(with view: FavoriteLocationListViewProtocol) {
        let viewController = view as! FavoriteLocationListViewController
        
        let presenter = FavoriteLocationListPresenter(viewController: viewController)
        let interactor = FavoriteLocationListInteractor(presenter: presenter)
        let router = FavoriteLocationListRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.router = router
        presenter.interactor = interactor
    }
}
