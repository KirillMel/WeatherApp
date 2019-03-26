//
//  Parsing.swift
//  weatherApp
//
//  Created by kirill on 3/20/19.
//  Copyright © 2019 kirill. All rights reserved.
//

import Foundation
import ObjectMapper

class ParserEntity<T> where T: Mappable{
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
    func parseRaw(_ data: Any?) -> (temperature: Int, description: String)? {
        let raw = data as! NSDictionary
        let description = (((raw["weather"] as! NSArray)[0] as! NSDictionary)["description"]) as? String
        let temperature = (((raw["main"] as! NSDictionary)["temp"] as! Double)  - CELVIN_TO_CELSIUS).toInt()

        guard temperature != nil, description != nil else { return nil }
        
        return (temperature!, description!)
    }
    
    func parseArray(_ data: Any?) -> [DetailedWeather] {
        let arrayOfData = (data as? NSDictionary)?["list"] as! NSArray
        var resultArray = [DetailedWeather]()
        
        for item in arrayOfData {
            let rawValue = parseRaw(item)
            resultArray.append(DetailedWeather(time: "\((item as! NSDictionary)["dt_txt"] ?? "")", temperature: rawValue?.temperature, description: rawValue?.description))
        }
        return resultArray
    }
}
