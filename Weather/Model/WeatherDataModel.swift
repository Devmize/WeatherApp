//
//  WeatherDataModel.swift
//  Weather
//
//  Created by Евгений Мизюк on 21.06.2022.
//

import Foundation

struct WeatherDataModel: Decodable {
    let lat: Double
    let lon: Double
    let current: Current
    let hourly: [Hourly]
    let daily: [Daily]
}

struct Current: Decodable {
    let dt: Int
    let temp: Double
    let pressure: Int
    let humidity: Int
    let clouds: Int
    let wind_speed: Double
    let weather: [Weather]
}

struct Hourly: Decodable {
    let dt: Int
    let temp: Double
    let pressure: Int
    let humidity: Int
    let clouds: Int
    let wind_speed: Double
    let weather: [Weather]
}

struct Daily: Decodable {
    let dt: Int
    let temp: Temp
    let pressure: Int
    let humidity: Int
    let clouds: Int
    let wind_speed: Double
    let weather: [Weather]
}

struct Temp: Decodable {
    let day: Double
    let min: Double
    let max: Double
    let night: Double
    let eve: Double
    let morn: Double
}

struct Weather: Decodable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}


