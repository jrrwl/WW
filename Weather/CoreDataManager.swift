//
//  CoreDataManager.swift
//  Weather
//
//  Created by Vladimir Illukovich on 8.09.22.
//

import Foundation
import UIKit
import CoreData

extension WeatherCoreData {
    func getWeatherCoreDataArray(context: NSManagedObjectContext) -> [WeatherCoreData] {
        var weatherDataArray = [WeatherCoreData]()
        do {
            weatherDataArray = try context.fetch(WeatherCoreData.fetchRequest())
        } catch  {
            //error
        }
        return weatherDataArray
    }
    
    func createWeatherCoreData(context: NSManagedObjectContext) -> WeatherCoreData {
        let entity = NSEntityDescription.entity(forEntityName: "WeatherCoreData", in: context)
        let weatherCoreData = WeatherCoreData(entity: entity!, insertInto: context)
        return weatherCoreData
    }
    func save() {
        do {
            try (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext.save()
        } catch {
            //error
        }
    }
}
