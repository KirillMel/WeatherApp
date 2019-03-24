//
//  FavoriteLocationListView.swift
//  weatherApp
//
//  Created by kirill on 3/21/19.
//  Copyright © 2019 kirill. All rights reserved.
//

import UIKit

class FavoriteLocationListViewController: UIViewController, FavoriteLocationListViewProtocol, TransitionHandlerProtocol {
    var presenter: FavoriteLocationListPresenterToViewProtocol!
    let configurator: FavoriteLocationListConfiguratorProtocol = FavoriteLocationListConfigurator()
    
    @IBOutlet weak var tableView: UITableView!
    var headerLabel: UILabel?
    
    var refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        
        presenter.setUpModule()
        setUpUI()
    }
    
    //MARK: - implementation FavoriteLocationListViewProtocol
    func updateTable() {
        headerLabel?.text = UserDefaults.standard.string(forKey: "lastUpdates") ?? "Not updated yet"
        
        self.tableView.reloadData()
    }
    
    //MARK: - helper methods
    private func setUpUI() {
        let width = self.tableView.frame.width
        //setup header label
        headerLabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: 30))
        headerLabel?.textAlignment = .center
        headerLabel?.text = UserDefaults.standard.string(forKey: "lastUpdates") ?? "Not updated yet"
        headerLabel?.font = headerLabel?.font.withSize(13)
        
        self.tableView.tableHeaderView = headerLabel
        //setup refresh control
        self.tableView.refreshControl = refreshControl
        self.refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
    }
    
    //MARK: - gesture on refresh
    @objc private func refreshData(_ sender: Any) {
        presenter.updateLocationsData()
        self.refreshControl.endRefreshing()
    }
}

extension FavoriteLocationListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        presenter.locationDidSelect(id: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.locationsCount()
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            presenter.locationDeleted(withId: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "cell") as? LocationCell
        
        let item = presenter.getLocationData(forId: indexPath.row)
        
        cell?.regionLabel.text = item.region
        cell?.countryLabel.text = item.country
        cell?.weatherLabel.text = item.weather
        cell?.weatherImageDescription?.image = UIImage(named: item.weatherImage)
        cell?.weatherImageDescription?.contentMode = .scaleToFill
        
        return cell ?? UITableViewCell(style: .default, reuseIdentifier: nil)
    }
}

