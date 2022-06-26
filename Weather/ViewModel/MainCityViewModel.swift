//
//  MainCityViewModel.swift
//  Weather
//
//  Created by Евгений Мизюк on 20.06.2022.
//

import Foundation

class MainCityViewModel {
    
    private let service: WeatherService = WeatherService.service
    
    var city: CityModel? = nil
    
    func getWeatherData(city: CityModel, completionHandler: @escaping (CityModel) -> (Void)) {
        self.service.fetchWeather(lat: city.weather.lat, lon: city.weather.lon) { [weak self] weatherData in
            guard let city = CityModel(weather: weatherData, name: city.name) else { return }
            self?.city = city
            completionHandler(city)
        }
    }
}
