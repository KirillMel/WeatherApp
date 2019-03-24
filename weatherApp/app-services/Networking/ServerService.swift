//
//  ServerService.swift
//  weatherApp
//
//  Created by kirill on 3/20/19.
//  Copyright © 2019 kirill. All rights reserved.
//

import Foundation

class ServerTemperatureService {
    private let alamofire = AlamofireWrapper.shared
    private var parser = ParserRaw()
    private var networkProtocol: NetworkProtocol?
    private var route: String = "https://api.openweathermap.org/data/2.5/weather"
    private let key = "9c00cdea5b57e45ab0d21383d6247b98"
    
    func setUpService(success: @escaping ((Int, String)?) -> Void, fail: @escaping (String?) -> Void) {
        self.networkProtocol = NetworkingOutput(successHandler: { [weak self] (result) in
            success(self?.parser.parse(result) ?? (0,""))        },
                                                failHandler : fail)
    }
    
    func getTemperatur(latitude: Double, longitute: Double) {
        let request = RequestBuilder(route: route, method: .get, headers: nil, params: ["lat": "\(latitude)", "lon":"\(longitute)", "APPID": key])
        alamofire.performRequest(urlRequest: request, handlers: networkProtocol!)
    }
}
