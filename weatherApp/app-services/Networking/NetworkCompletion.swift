//
//  NetworkCompletion.swift
//  weatherApp
//
//  Created by kirill on 3/20/19.
//  Copyright © 2019 kirill. All rights reserved.
//

import Foundation

typealias SuccessCompletionHandler = (Any) -> Void
typealias FailCompletionHandler = (String?) -> Void

protocol NetworkProtocol: class {
    var successHandler: SuccessCompletionHandler {get}
    var failHandler: FailCompletionHandler {get}
}

class NetworkingOutput: NetworkProtocol {
    var successHandler: SuccessCompletionHandler
    var failHandler: FailCompletionHandler
    
    required init(successHandler: @escaping SuccessCompletionHandler, failHandler: @escaping FailCompletionHandler) {
        self.successHandler = successHandler
        self.failHandler = failHandler
    }
}
