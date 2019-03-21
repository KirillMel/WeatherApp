//
//  DataManager.swift
//  weatherApp
//
//  Created by kirill on 3/21/19.
//  Copyright © 2019 kirill. All rights reserved.
//

import Foundation
import CoreData

protocol LocalSorageProtocol: class {
    func saveItem(_ latitude: Double, _ longitude: Double, _ geolocation: (String, String),  _ detail: String, _ temperature: Int) -> Void
    func deleteItem(withName name: String) throws -> Void
}

class LocalStorage: LocalSorageProtocol {
    let context = AppDelegate.viewContext
    
    func saveItem(_ latitude: Double, _ longitude: Double, _ geolocation: (String, String), _ detail: String, _ temperature: Int) {
        let country = geolocation.0
        let region = geolocation.1
        
        let _ = try? Location.initOrFind(name: region, country: country, latitude: latitude, longitude: longitude, temperature: temperature, detail: detail)
        
        try? context.save()
        
        get()
    }
    
    func deleteItem(withName name: String) throws -> Void {
        let request: NSFetchRequest<Location> = Location.fetchRequest()
        let predicate = NSPredicate(format: "name = %@", "\(name)")
        
        request.predicate = predicate
        
        do {
            let matches = try context.fetch(request)
            if matches.count > 0 {
                let item = matches[0]
                context.delete(item)
                try context.save()
            }
            
            try? deleteWeather(withLocationName: name)
            
        } catch {
            throw error
        }
    }
    
    private func deleteWeather(withLocationName name: String) throws -> Void {
        let request: NSFetchRequest<Weather> = Weather.fetchRequest()
        let predicate = NSPredicate(format: "locationName = %@", "\(name)")
        
        request.predicate = predicate
        
        do {
            let matches = try context.fetch(request)
            if matches.count > 0 {
                let item = matches[0]
                context.delete(item)
                try? context.save()
            }
            
            get()
            
        } catch {
            throw error
        }
    }
    
    private func get() { //tmp
        let request: NSFetchRequest<Location> = Location.fetchRequest()
        let matches = try? context.fetch(request)
        if matches!.count > 0 {
            for item in matches! {
                print(item.name)
            }
        }
    }
}
