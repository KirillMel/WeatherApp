//
//  MapScreenRouter.swift
//  weatherApp
//
//  Created by kirill on 3/18/19.
//  Copyright © 2019 kirill. All rights reserved.
//

import Foundation

class MapScreenRouter: MapScreenRouterProtocol {
    var viewController: TransitionHandlerProtocol
    
    required init(viewController: TransitionHandlerProtocol) {
        self.viewController = viewController
    }
}
