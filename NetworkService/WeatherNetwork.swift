//
//  APIJson.swift
//  WeatherAPI’
//
//  Created by Andriy on 25.05.2022.
//

import Foundation

class WeatherNetwork {
    
    static let weatherAPIKey = "e52288a13981475ab48fd3acdd970940"
    static let weatherHost = "https:api.weatherbit.io"
    
    static func fetchWeather(location: String, complititon: @escaping (LocationModel?) -> ()) {
        let url = "\(weatherHost)/v2.0/forecast/daily?&\(location)&key=\(weatherAPIKey)"
        guard let url = URL(string: url) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            
            do {
            let jsonDecoder = try JSONDecoder().decode(LocationModel.self, from: data)
            DispatchQueue.main.async {
                complititon(jsonDecoder)
            }
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
}

//"https://api.weatherbit.io/v2.0/forecast/daily?&lat=49.8382600&lon=24.0232400&key=e52288a13981475ab48fd3acdd970940"

