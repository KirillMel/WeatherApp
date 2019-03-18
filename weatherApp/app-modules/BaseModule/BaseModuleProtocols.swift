//
//  BaseModuleProtocols.swift
//  weatherApp
//
//  Created by kirill on 3/18/19.
//  Copyright © 2019 kirill. All rights reserved.
//

import Foundation

protocol BaseModuleViewProtocol: class {
    func showAlert(title: String, message: String) -> Void
}

protocol BaseModulePresenterToViewProtocol: class {
    
}

protocol BaseModulePresenterToInteractorProtocol: class {
    
}

protocol BaseModuleInteractorProtocol: class {
    
}

protocol BaseModuleRouterProtocol: class {
    
}

protocol BaseModuleConfiguratorProtocol: class {
    
}

protocol TransitionHandlerProtocol: class {
    
}
