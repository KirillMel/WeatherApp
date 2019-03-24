//
//  DetailLocationRouter.swift
//  weatherApp
//
//  Created by kirill on 3/24/19.
//  Copyright © 2019 kirill. All rights reserved.
//

import Foundation

class DetailLocationRouter: DetailLocationRouterProtocol {
    //MARK: - Viper layers
    weak var viewController: TransitionHandlerProtocol!
    
    required init(viewController: TransitionHandlerProtocol) {
        self.viewController = viewController
    }
}
