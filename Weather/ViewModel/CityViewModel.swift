//
//  WeatherViewModel.swift
//  Weather
//
//  Created by Евгений Мизюк on 10.06.2022.
//

import Foundation

class CityViewModel {
    
    private let service: WeatherService = WeatherService.service
    
    var cities: [CityModel] = []
    var filteredCities: [CityModel] = []
    
    func getCityWeather(city: String, completionHandler: @escaping (CityModel) -> ()) {
        self.service.getCoordinateFrom(city: city) { [weak self] coordinate, error in
            guard let coordinate = coordinate, error == nil else { return }
            self?.service.fetchWeather(lat: coordinate.latitude, lon: coordinate.longitude) { [weak self] weatherData in
                guard let city = CityModel(weather: weatherData, name: city) else { return }
                self?.cities.append(city)
                completionHandler(city)
            }
        }
    }
}
