//
//  CityModel.swift
//  Weather
//
//  Created by Евгений Мизюк on 21.06.2022.
//

import Foundation

struct CityModel {
    
    let weather: WeatherDataModel
    let name: String
    let temp: Double
    let description: String
    
    init?(weather: WeatherDataModel, name: String) {
        self.weather = weather
        self.name = name
        self.temp = weather.current.temp
        self.description = weather.current.weather[0].description
    }
}
