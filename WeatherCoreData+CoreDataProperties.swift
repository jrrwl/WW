//
//  WeatherCoreData+CoreDataProperties.swift
//  Weather
//
//  Created by Vladimir Illukovich on 8.09.22.
//
//

import Foundation
import CoreData


extension WeatherCoreData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WeatherCoreData> {
        return NSFetchRequest<WeatherCoreData>(entityName: "WeatherCoreData")
    }

    @NSManaged public var dateCD: String?
    @NSManaged public var maxtempCCD: Double
    @NSManaged public var conditionCD: String?
    @NSManaged public var sunriseCD: String?
    @NSManaged public var sunsetCD: String?
    @NSManaged public var iconCD: String?

}

extension WeatherCoreData : Identifiable {
    
}
