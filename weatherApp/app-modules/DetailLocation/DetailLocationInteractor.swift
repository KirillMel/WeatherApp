//
//  DetailLocationInteractor.swift
//  weatherApp
//
//  Created by kirill on 3/24/19.
//  Copyright © 2019 kirill. All rights reserved.
//

import Foundation

class DetailLocationInteractor: DetailLocationInteractorProtocol {
    //MARK: - Viper layers
    weak var presenter: DetailLocationPresenterToInteractorProtocol!
    
    private weak var location: Location?
    
    required init(presenter: DetailLocationPresenterToInteractorProtocol) {
        self.presenter = presenter
    }
    
    //MARK: - implementation DetailLocationInteractorProtocol
    func setSelectedlocation(_ location: Location) {
        self.location = location
    }
}
