//
//  DetailLocationView.swift
//  weatherApp
//
//  Created by kirill on 3/24/19.
//  Copyright © 2019 kirill. All rights reserved.
//

import UIKit

typealias DetailLocationPresenterForView = DetailLocationPresenterToViewProtocol & DetailLocationModuleInputProtocol

class DetailLocationViewController: UIViewController, DetailLocationViewProtocol, TransitionHandlerProtocol{
    
    //MARK: - Viper layers
    let configurator: DetailLocationConfiguratorProtocol = DetailLocationConfigurator()
    var presenter: DetailLocationPresenterForView?
    
    @IBOutlet weak var weatherDescriptionLabel: UILabel!
    
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //MARK: - implementation DetailLocationViewProtocol
    func updateView(tmp: String) {
        self.title = tmp
        weatherDescriptionLabel?.text = tmp
    }
}

extension DetailLocationViewController: DetailLocationModuleLoader {
    var moduleInput: DetailLocationModuleInputProtocol {
        return presenter!
    }
    
    func createModule() {
        guard presenter == nil else { return }
        
        configurator.configure(with: self)
    }
}
