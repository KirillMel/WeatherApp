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
    
    func updateViewWithData(tmp: String) {
        viewController.updateView(tmp: tmp)
    }
    
    //MARK: - impementation DetailLocationPresenterToViewProtocol
    //TODO : implement stubs
    
    //MARK: - impementation DetailLocationPresenterToInteractorProtocol
    //TODO : implement stubs
}

extension DetailLocationPresenter: DetailLocationModuleInputProtocol {
    func setUpWith(location: Location) {
        interactor.setSelectedlocation(location)
        
        self.updateViewWithData(tmp: location.name ?? "")
    }
}
