//
//  LocationModel.swift
//  WeatherAPI’
//
//  Created by Andriy on 25.05.2022.
//

import Foundation

struct LocationModel: Decodable {
    var data: [WeatherModel]
    var city_name: String
}
