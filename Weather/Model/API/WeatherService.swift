//
//  WeatherService.swift
//  Weather
//
//  Created by Евгений Мизюк on 10.06.2022.
//

import Foundation
import CoreLocation

class WeatherService {
    
    static let service: WeatherService = WeatherService()
    
    private let apiKey: String = "a87a8cddfd91e6030e97bd39276449fd"
    private let weatherPath: String = "https://api.openweathermap.org/data/2.5/onecall?"
    
    public func fetchWeather(lat: Double, lon: Double, completionHandler: @escaping(WeatherDataModel) -> Void) {
        let session = URLSession.shared
        let url = URL(string: weatherPath + "lat=\(lat)" + "&lon=\(lon)" + "&exclude=minutely" + "&units=metric" + "&lang=ru" + "&appid=\(apiKey)")!
        let task = session.dataTask(with: url) { data, response, error in
            guard let data = data else {
                print("Data error: \(error!.localizedDescription)")
                return
            }
            
            do {
                let weatherData = try JSONDecoder().decode(WeatherDataModel.self, from: data)
                completionHandler(weatherData)
            } catch {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
    
    public func getCoordinateFrom(city: String, completionHandler: @escaping(_ coordinate: CLLocationCoordinate2D?, _ error: Error?) -> ()) {
        CLGeocoder().geocodeAddressString(city) { placemark, error in
            completionHandler(placemark?.first?.location?.coordinate, error)
        }
    }
}
