//
//  DetailLocationProtocols.swift
//  weatherApp
//
//  Created by kirill on 3/24/19.
//  Copyright © 2019 kirill. All rights reserved.
//

import Foundation

protocol DetailLocationViewProtocol: BaseModuleViewProtocol {
    func updateView(tmp: String) -> Void
}

protocol DetailLocationModuleLoader: class {
    var moduleInput: DetailLocationModuleInputProtocol {get}
    
    func createModule()
}

protocol DetailLocationModuleInputProtocol: class {
    func setUpWith(location: Location) -> Void
}

protocol DetailLocationPresenterToViewProtocol: BaseModulePresenterToViewProtocol {
    
}

protocol DetailLocationPresenterToInteractorProtocol: BaseModulePresenterToInteractorProtocol {
    
}

protocol DetailLocationInteractorProtocol: BaseModuleInteractorProtocol {
    func setSelectedlocation(_ location: Location) -> Void
}

protocol DetailLocationRouterProtocol: BaseModuleRouterProtocol {
    
}

protocol DetailLocationConfiguratorProtocol: BaseModuleConfiguratorProtocol {
    func configure(with view: DetailLocationViewProtocol) -> Void
}
