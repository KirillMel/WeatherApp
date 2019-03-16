//
//  ThemeProtocol.swift
//  weatherApp
//
//  Created by kirill on 3/16/19.
//  Copyright © 2019 kirill. All rights reserved.
//

import UIKit

protocol ThemeProtocol: class {
    var backgroungColor: UIColor {get}
    var mainTextColor: UIColor {get}
    var navBarTitleColor: UIColor {get}
}
