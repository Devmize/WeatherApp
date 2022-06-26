//
//  WeatherProtocol.swift
//  Weather
//
//  Created by Евгений Мизюк on 15.06.2022.
//

import Foundation

protocol WeatherProtocol {
    var dt: Int { get set }
    var weather: [Weather] { get set }
}
