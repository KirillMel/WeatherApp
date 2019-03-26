//
//  ServerService.swift
//  weatherApp
//
//  Created by kirill on 3/20/19.
//  Copyright © 2019 kirill. All rights reserved.
//

import Foundation

class ServerService {
    private let alamofire = AlamofireWrapper.shared
    private var parser = ParserRaw()
    private var networkProtocol: NetworkProtocol?
    private var route: String = "https://api.openweathermap.org/data/2.5/weather"
    private let key = "9c00cdea5b57e45ab0d21383d6247b98"
    
    func setUpService(route: Route,success: @escaping (Any?) -> Void, fail: @escaping (String?) -> Void) {
        self.route = route.rawValue
        self.networkProtocol = NetworkingOutput(successHandler: { [weak self] (result) in
                switch route {
                    case .defaultWeather: success(self?.parser.parseRaw(result) ?? (0,"")); break
                    case .detailedWeather: success(self?.parser.parseArray(result)); break
                }
            },
                                                failHandler : fail)
    }
    
    func getWeather(latitude: Double, longitute: Double) {
        let request = RequestBuilder(route: route, method: .get, headers: nil, params: ["lat": "\(latitude)", "lon":"\(longitute)", "APPID": key])
        alamofire.performRequest(urlRequest: request, handlers: networkProtocol!)
    }
}

enum Route: String {
    case detailedWeather = "https://api.openweathermap.org/data/2.5/forecast"
    case defaultWeather = "https://api.openweathermap.org/data/2.5/weather"
}
