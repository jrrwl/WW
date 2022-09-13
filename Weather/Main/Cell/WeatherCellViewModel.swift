//
//  CellViewModel.swift
//  Weather
//
//  Created by Vladimir Illukovich on 30.08.22.
//

import Foundation

class WeatherCellViewModel {
    var date: String
    var maxTempC: Double
    
    init(weatherModel: WeatherModel) {
        self.date = weatherModel.date
        self.maxTempC = weatherModel.maxTempC
    }
}
