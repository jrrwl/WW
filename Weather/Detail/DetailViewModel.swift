//
//  DetailViewModel.swift
//  Weather
//
//  Created by Vladimir Illukovich on 30.08.22.
//

import Foundation

class DetailViewModel {
    private let selectedDate: WeatherModel

    init(selectedDate: WeatherModel) {
        self.selectedDate = selectedDate
    }
    
    func getSelectedDate() -> WeatherModel {
        return self.selectedDate
    }
}
