//
//  AlamofireWrapper.swift
//  weatherApp
//
//  Created by kirill on 3/19/19.
//  Copyright © 2019 kirill. All rights reserved.
//

import Foundation
import Alamofire

class AlamofireWrapper {
    static var shared = AlamofireWrapper()
    
    private init() { }
    
    func performRequest(urlRequest: URLRequestConvertible, handlers: NetworkProtocol) {
        Alamofire.request(urlRequest).responseJSON { response in
            if response.result.isSuccess {
                guard let value = response.result.value else { return }
                handlers.successHandler(value)
            } else {
                handlers.failHandler(response.error?.localizedDescription)
            }
        }
    }
    
    var isConnectedToInternet: Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}
