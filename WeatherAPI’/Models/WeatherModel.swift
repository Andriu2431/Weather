//
//  DataModel.swift
//  WeatherAPI’
//
//  Created by Andriy on 25.05.2022.
//

import Foundation

struct WeatherModel: Decodable {
    var valid_date: String
    var wind_spd: Float
    var temp: Float
//    var max_temp: Float
//    var min_temp: Float
    var app_max_temp: Float
    var pop: Int
    var weather: WeatherIcon
}
