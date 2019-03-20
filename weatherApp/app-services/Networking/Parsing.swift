//
//  Parsing.swift
//  weatherApp
//
//  Created by kirill on 3/20/19.
//  Copyright © 2019 kirill. All rights reserved.
//

import Foundation
import ObjectMapper

class ParserEntety<T> where T: Mappable{
    func parse(_ data: Any?) -> T? {
        guard let object = data as? NSObject else { return nil }
        return Mapper<T>().map(JSONObject: object)
    }
    
    func parse(_ data:Any?) -> [T] {
        guard let object = data as? NSObject else { return [T]() }
        return Mapper<T>().mapArray(JSONObject: object) ?? [T]()
    }
}

class ParserRaw{
    func parse(_ data: Any?) -> (Int, String)? {
        let b = data as! NSDictionary
        let description = (((b["weather"] as! NSArray)[0] as! NSDictionary)["description"]) as? String
        let temperature = (((b["main"] as! NSDictionary)["temp"] as! Double)  - CELVIN_TO_CELSIUS).toInt()

        guard temperature != nil, description != nil else { return nil}
        
        return (temperature!, description!)
    }
    
    func parse(_ data: Any?) -> [String] {
        //guard let object = data as? NSObject else { return [String]() }
        return  [String]()
    }
}
