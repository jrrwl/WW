//
//  ViewModel.swift
//  Weather
//
//  Created by Vladimir Illukovich on 26.08.22.
//

import Foundation
import CoreData


public class MainViewModel {
    var welcome: Observable<[WeatherModel]> = Observable([])
    
//    var weatherCoreDataArray: [WeatherCoreData]?
    
    
    public func weatherViewModelFromCoreData(context: NSManagedObjectContext) {
        let weatherCoreDataArray = WeatherCoreData().getWeatherCoreDataArray(context: context).sorted {$0.dateCD ?? "" < $1.dateCD ?? ""}
        self.welcome.value = weatherCoreDataArray.compactMap({
            WeatherModel(date: $0.dateCD ?? "", maxTempC: $0.maxtempCCD, condition: $0.conditionCD ?? "", sunrise: $0.sunriseCD ?? "", sunset: $0.sunsetCD ?? "", icon: $0.iconCD ?? "")
        })
    }
    
    public func request(context: NSManagedObjectContext) {
        let semaphore = DispatchSemaphore (value: 0)

        var request = URLRequest(url: URL(string: "http://api.weatherapi.com/v1/forecast.json?key=980a8eabfa2d43fdb1c115219221409&q=warsaw&days=14")!,timeoutInterval: Double.infinity)
        request.httpMethod = "GET"

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, let weatherData = try? JSONDecoder().decode(Welcome.self, from: data) else {
            print(String(describing: error))
            semaphore.signal()
            return
          }
            self.welcome.value = weatherData.forecast?.forecastday?.compactMap({
                WeatherModel(date: $0.date ?? "", maxTempC: $0.day?.maxtempC ?? 0.0, condition: $0.day?.condition?.text ?? "", sunrise: $0.astro?.sunrise ?? "", sunset: $0.astro?.sunset ?? "", icon: $0.day?.condition?.icon ?? "")
            })
            
            var weatherCoreDataArray = WeatherCoreData().getWeatherCoreDataArray(context: context)
            while !weatherCoreDataArray.isEmpty {
                let w = weatherCoreDataArray[0]
                context.delete(w)
                weatherCoreDataArray.remove(at: 0)
            }
            for w in self.welcome.value! {
                let weatherCoreData = WeatherCoreData().createWeatherCoreData(context: context)
                weatherCoreData.dateCD = w.date
                weatherCoreData.maxtempCCD = w.maxTempC
                weatherCoreData.conditionCD = w.condition
                weatherCoreData.sunriseCD = w.sunrise
                weatherCoreData.sunsetCD = w.sunset
                weatherCoreData.iconCD = w.icon
                weatherCoreDataArray.append(weatherCoreData)
            }
            do {
                try context.save()
            } catch {
                //error
            }
            
//          print(String(data: data, encoding: .utf8)!)
          semaphore.signal()
        }

        task.resume()
        semaphore.wait()
    }
}

public struct WeatherModel {
    var date: String
    var maxTempC: Double
    var condition: String
    var sunrise: String
    var sunset: String
    var icon: String
}
