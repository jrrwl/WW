//
//  ViewModel.swift
//  Weather
//
//  Created by Vladimir Illukovich on 26.08.22.
//

import Foundation

public class MainViewModel {
    var welcome: Observable<[WeatherModel]> = Observable([])
    
    public func request() {
        let semaphore = DispatchSemaphore (value: 0)

        var request = URLRequest(url: URL(string: "http://api.weatherapi.com/v1/forecast.json?key=9820c39fe1ab4c1499e153616223008&q=warsaw&days=14")!,timeoutInterval: Double.infinity)
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
          print(String(data: data, encoding: .utf8)!)
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
