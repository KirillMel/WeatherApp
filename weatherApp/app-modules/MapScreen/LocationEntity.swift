//
//  LocationEntity.swift
//  weatherApp
//
//  Created by kirill on 3/20/19.
//  Copyright © 2019 kirill. All rights reserved.
//

import Foundation
import CoreData

extension Location {
    class func initOrFind(name: String, country: String , latitude: Double, longitude: Double, temperature: Int, detail: String)  throws -> Location {
        let context = AppDelegate.viewContext
        let request: NSFetchRequest<Location> = Location.fetchRequest()
        let predicate = NSPredicate(format: "name = %@", "\(name)")
        
        request.predicate = predicate
        
        do {
            let matches = try context.fetch(request)
            if matches.count > 0 {
                return matches[0]
            }
            
        } catch {
            throw error
        }
        
        let newItem = Location(context: context)
        newItem.name = name
        newItem.country = country
        newItem.latitude = latitude
        newItem.longitude = longitude
        
        newItem.weather = try Weather.initOrFind(locationName: name, temperature: temperature, detail: detail)
        
        return newItem
    }
}

extension Weather{
    class func initOrFind(locationName: String, temperature: Int, detail: String)  throws -> Weather {
        let context = AppDelegate.viewContext
        let request: NSFetchRequest<Weather> = Weather.fetchRequest()
        let predicate = NSPredicate(format: "locationName = %@", "\(locationName)")
        
        request.predicate = predicate
        
        do {
            let matches = try context.fetch(request)
            if matches.count > 0 {
                let item = matches[0]
                item.detail = detail
                item.temperature = Int64(temperature)
                return item
            }
            
        } catch {
            throw error
        }
        
        let newItem = Weather(context: context)
        newItem.detail = detail
        newItem.temperature = Int64(temperature)
        
        return newItem
    }
}
