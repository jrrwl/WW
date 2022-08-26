//
//  Request.swift
//  Weather
//
//  Created by Vladimir Illukovich on 15.08.22.
//

import Foundation

var publicWeatherData: Welcome?

public func request(viewModel: ViewModel) {
    let semaphore = DispatchSemaphore (value: 0)

    var request = URLRequest(url: URL(string: "http://api.weatherapi.com/v1/forecast.json?key=004c97ae6e584f08b33164304221508&q=warsaw&days=14")!,timeoutInterval: Double.infinity)
    request.httpMethod = "GET"

    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        guard let data = data, let weatherData = try? JSONDecoder().decode(Welcome.self, from: data) else {
        print(String(describing: error))
        semaphore.signal()
        return
      }
        viewModel.welcome.value = weatherData.forecast?.forecastday?.compactMap({
            TableViewModel(date: $0.date ?? "", maxTempC: $0.day?.maxtempC ?? 0.0, condition: $0.day?.condition?.text ?? "", sunrise: $0.astro?.sunrise ?? "", sunset: $0.astro?.sunset ?? "", icon: $0.day?.condition?.icon ?? "")
        })
        publicWeatherData = weatherData
//      print(String(data: data, encoding: .utf8)!)
      semaphore.signal()
    }

    task.resume()
    semaphore.wait()
}

