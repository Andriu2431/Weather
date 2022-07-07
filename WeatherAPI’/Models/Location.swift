//
//  Location.swift
//  WeatherAPI’
//
//  Created by Andriy on 28.05.2022.
//

import Foundation
import CoreLocation

class Location {
    
    static let shared = Location()
    
    var coordinate: CLLocation?
    var city = ""
}
