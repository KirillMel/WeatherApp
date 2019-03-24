//
//  FavoriteLocationListRouter.swift
//  weatherApp
//
//  Created by kirill on 3/21/19.
//  Copyright © 2019 kirill. All rights reserved.
//

import Foundation

class FavoriteLocationListRouter: FavoriteLocationListRouterProtocol {
    var viewController: TransitionHandlerProtocol!
    
    required init(viewController: TransitionHandlerProtocol) {
        self.viewController = viewController
    }
    
    func moveToDetail(location: Location) {
        viewController.openModule(segueIdentifier: "showWeatherDetail", configurationBlock: { input in
            
        })
    }
}
