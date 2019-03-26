//
//  DetailLocationView.swift
//  weatherApp
//
//  Created by kirill on 3/24/19.
//  Copyright © 2019 kirill. All rights reserved.
//

import UIKit

typealias DetailLocationPresenterForView = DetailLocationPresenterToViewProtocol & DetailLocationModuleInputProtocol

class DetailLocationViewController: UIViewController, DetailLocationViewProtocol, TransitionHandlerProtocol {
    //MARK: - Viper layers
    let configurator: DetailLocationConfiguratorProtocol = DetailLocationConfigurator()
    var presenter: DetailLocationPresenterForView?
    //MARK: - Outlets
    @IBOutlet weak var weatherDescriptionLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.setUpViewWithData()
    }
    
    //MARK: - implementation DetailLocationViewProtocol
    func updateView(withTitle title: String) {
        self.title = title
    }
    
    func updateView(mainDescription: (temperature: String, description: String, image: String)) {
        temperatureLabel.text = mainDescription.temperature
        weatherDescriptionLabel.text = mainDescription.description
        weatherImageView.image = UIImage(named: mainDescription.image)
    }
    
    func updateTable() {
        tableView.reloadData()
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

extension DetailLocationViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.getCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "weatherDetail") as? WeatherDetailCell
        
        let item = presenter?.getDetaliedWeather(byId: indexPath.row)
        
        cell?.descriptionLabel.text = item?.description
        cell?.timeLabel.text = item?.time
        cell?.weatherImage?.image = UIImage(named: item?.image ?? "clear.png")
        
        return cell ?? UITableViewCell(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 44))
    }
}
