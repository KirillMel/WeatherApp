//
//  RequestBuilder.swift
//  weatherApp
//
//  Created by kirill on 3/19/19.
//  Copyright © 2019 kirill. All rights reserved.
//

import Foundation
import Alamofire

class RequestBuilder: URLRequestConvertible {
    var route: String
    var method: HTTPMethod
    var headers: [String:String]?
    var params: [String:Any]?
    
    required init(route: String?, method: HTTPMethod?, headers: [String: String]?, params: [String: Any]?) {
        self.route = route ?? ""
        self.method = method ?? .get
        self.headers = headers
        self.params = params
    }
    
    func asURLRequest() throws -> URLRequest {
        var url = URLComponents(string: route)
        guard let params = params else { return try URLRequest(url: url!, method: method, headers: headers)}
        
        url?.queryItems = getQueryItems(params: params)
        let request = try URLRequest(url: url!, method: method, headers: headers)
        
        return request
    }
    
    func getQueryItems(params: [String: Any]) -> [URLQueryItem]{
        var query = [URLQueryItem]()
        
        for key in params.keys {
            query.append(URLQueryItem(name: key, value: "\(params[key] ?? "")"))
        }
        
        return query
    }
}
