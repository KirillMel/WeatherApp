//
//  TransitionHandlerExtension.swift
//  weatherApp
//
//  Created by kirill on 3/24/19.
//  Copyright © 2019 kirill. All rights reserved.
//

import UIKit

typealias ConfigurationBlock = (Any?) -> Void

struct SegueInfo {
    var configurationBlock: ((Any?) -> Void)?
}

extension TransitionHandlerProtocol where Self: UIViewController {
    func openModule(segueIdentifier: String, configurationBlock: @escaping (Any?) -> Void) {
        var segueInfo = SegueInfo()
        segueInfo.configurationBlock = configurationBlock
        performSegue(withIdentifier: segueIdentifier, sender: segueInfo)
    }
    
    func closeModule() {
        self.dismiss(animated: true, completion: nil)
    }
}
