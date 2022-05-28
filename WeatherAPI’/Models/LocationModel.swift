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
//    var lon: Double
//    var timezone: String
//    var lat: Double
//    var country_code: String
    
}

//extension LocationModel {
//    init?(JSON: [String : AnyObject]) {
//        guard let data = JSON["data"] as? [DataModel],
//              let city_name = JSON["city_name"] as? String,
//              let lon = JSON["lon"] as? Double,
//              let timezone = JSON["timezone"] as? String,
//              let lat = JSON["lat"] as? Double,
//              let country_code = JSON["country_code"] as? String else {
//            return nil
//        }
//        self.data = data
//        self.city_name = city_name
//        self.lon = lon
//        self.timezone = timezone
//        self.lat = lat
//        self.country_code = country_code
//
//    }
//}
