//
//  ViewModel.swift
//  Weather
//
//  Created by Vladimir Illukovich on 26.08.22.
//

import Foundation

public class ViewModel {
    var welcome: Observable<[TableViewModel]> = Observable([])
}

public struct TableViewModel {
    var date: String
    var maxTempC: Double
    var condition: String
    var sunrise: String
    var sunset: String
    var icon: String
}
