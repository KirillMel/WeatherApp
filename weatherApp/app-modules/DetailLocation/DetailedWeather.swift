//
//  DetailedWeather.swift
//  weatherApp
//
//  Created by kirill on 3/26/19.
//  Copyright © 2019 kirill. All rights reserved.
//

import Foundation

struct DetailedWeather {
    var time: String?
    var temperature: Int?
    var description: String?
    
    init(time: String?, temperature: Int?, description: String?) {
        self.time = time
        self.temperature = temperature
        self.description = description
    }
}
