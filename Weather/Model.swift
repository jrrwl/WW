//
//  Model.swift
//  Weather
//
//  Created by Vladimir Illukovich on 15.08.22.
//


import Foundation

struct Welcome: Codable {
    let forecast: Forecast?
}

struct Forecast: Codable {
    let forecastday: [Forecastday]?
}

struct Forecastday: Codable {
    let date: String?
    let dateEpoch: Int?
    let day: Day?
    let astro: Astro?
//    let hour: [Hour]?

    enum CodingKeys: String, CodingKey {
        case date
        case dateEpoch = "date_epoch"
        case day, astro
    }
}

struct Astro: Codable {
    let sunrise, sunset, moonrise, moonset: String?
    let moonPhase, moonIllumination: String?

    enum CodingKeys: String, CodingKey {
        case sunrise, sunset, moonrise, moonset
        case moonPhase = "moon_phase"
        case moonIllumination = "moon_illumination"
    }
}

struct Day: Codable {
    let maxtempC, maxtempF, mintempC, mintempF: Double?
    let avgtempC, avgtempF, maxwindMph, maxwindKph: Double?
    let totalprecipMm, totalprecipIn, avgvisKM: Double?
    let avgvisMiles, avghumidity, dailyWillItRain, dailyChanceOfRain: Int?
    let dailyWillItSnow, dailyChanceOfSnow: Int?
    let condition: Condition?
    let uv: Int?

    enum CodingKeys: String, CodingKey {
        case maxtempC = "maxtemp_c"
        case maxtempF = "maxtemp_f"
        case mintempC = "mintemp_c"
        case mintempF = "mintemp_f"
        case avgtempC = "avgtemp_c"
        case avgtempF = "avgtemp_f"
        case maxwindMph = "maxwind_mph"
        case maxwindKph = "maxwind_kph"
        case totalprecipMm = "totalprecip_mm"
        case totalprecipIn = "totalprecip_in"
        case avgvisKM = "avgvis_km"
        case avgvisMiles = "avgvis_miles"
        case avghumidity
        case dailyWillItRain = "daily_will_it_rain"
        case dailyChanceOfRain = "daily_chance_of_rain"
        case dailyWillItSnow = "daily_will_it_snow"
        case dailyChanceOfSnow = "daily_chance_of_snow"
        case uv, condition
    }
}

struct Condition: Codable {
    let text: String?
    let icon: String?
    let code: Int?
}
