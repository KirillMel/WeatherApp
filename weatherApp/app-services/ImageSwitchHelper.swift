//
//  ImageSwitchHelper.swift
//  weatherApp
//
//  Created by kirill on 3/23/19.
//  Copyright © 2019 kirill. All rights reserved.
//

import Foundation

class ImageSwitchHelper {
    static let shared = ImageSwitchHelper()
    
    func switchImage(description: String) -> String {
        let value = description.lowercased()
        switch(value) {
        case "clear sky" : return "clear.png"
        case "light rain" : return "light_rain.png"
        case "scattered clouds" : return "light_clouds.png"
        default: return "clouds.png"
        }
    }
}
