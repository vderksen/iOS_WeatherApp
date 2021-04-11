// Student ID: 153803184
// Student name: Valentina Derksen
// https://github.com/vderksen/iOS_MyOrder

//  Weather.swift
//  ValentinaDerksen_Weather
//
//  Created by Valya Derksen on 2021-04-10.
//

import Foundation

struct Weather : Codable {
    var temp : Double
    var feelsLike : Double
    var windSpeed : Double
    var windDirection : String
    var uvIndex : Double
    
    init(){
        self.temp = 0
        self.feelsLike = 0
        self.windSpeed = 0
        self.windDirection = "N/A"
        self.uvIndex = 0
    }
    
    enum CodingKeys : String, CodingKey {
        case temp = "temp_c"
        case feelsLike = "feelslike_c"
        case windSpeed = "wind_kph"
        case windDirection = "wind_dir"
        case uvIndex = "uv"
        case currentWeather = "current"
    }
    
    func encode(to encoder: Encoder) throws {
        // nothing to encode
    }
    
    init(from decoder: Decoder) throws {
        let response = try decoder.container(keyedBy: CodingKeys.self)
        let currentWeatherContainer = try response.decodeIfPresent(CurrentWeather.self, forKey: .currentWeather)
        self.temp = currentWeatherContainer?.temp ?? 0
        self.feelsLike = currentWeatherContainer?.feelsLike ?? 0
        self.windSpeed = currentWeatherContainer?.windSpeed ?? 0
        self.windDirection = currentWeatherContainer?.windDirection ?? "Unavaliable"
        self.uvIndex = currentWeatherContainer?.uvIndex ?? 0
    }
}

struct CurrentWeather : Codable {
    var temp : Double
    var feelsLike : Double
    var windSpeed : Double
    var windDirection : String
    var uvIndex : Double
    
    enum CodingKeys : String, CodingKey {
        case temp = "temp_c"
        case feelsLike = "feelslike_c"
        case windSpeed = "wind_kph"
        case windDirection = "wind_dir"
        case uvIndex = "uv"
    }
    
    init(from decoder: Decoder) throws {
        let response = try decoder.container(keyedBy: CodingKeys.self)
        self.temp = try response.decodeIfPresent(Double.self, forKey: .temp) ?? 0
        self.feelsLike = try response.decodeIfPresent(Double.self, forKey: .feelsLike) ?? 0
        self.windSpeed = try response.decodeIfPresent(Double.self, forKey: .windSpeed) ?? 0
        self.windDirection = try response.decodeIfPresent(String.self, forKey: .windDirection) ?? "Unavaliable"
        self.uvIndex = try response.decodeIfPresent(Double.self, forKey: .uvIndex) ?? 0
    }
    
    func encode(to encoder: Encoder) throws {
        // nothing to encode
    }
}
