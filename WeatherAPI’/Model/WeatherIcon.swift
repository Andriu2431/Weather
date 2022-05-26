//
//  WeatherIcon.swift
//  WeatherAPI’
//
//  Created by Andriy on 25.05.2022.
//

import Foundation

struct WeatherIcon: Decodable {
    var icon: String
    var code: Int
    var description: String
}
