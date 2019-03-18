//
//  AlertExtension.swift
//  weatherApp
//
//  Created by kirill on 3/18/19.
//  Copyright © 2019 kirill. All rights reserved.
//

import UIKit

extension BaseModuleViewProtocol where Self: UIViewController {
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(alertAction)
        self.present(alert, animated: true, completion: nil)
    }
}
