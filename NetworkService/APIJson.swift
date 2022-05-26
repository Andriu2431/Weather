//
//  APIJson.swift
//  WeatherAPI’
//
//  Created by Andriy on 25.05.2022.
//

import Foundation

class APIJson {
    static func fetchJson(url: String, complititon: @escaping (LocationModel?) -> ()) {
    
        guard let url = URL(string: url) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error)
                return
            }
            guard let data = data else { return }
    
            let decoder = JSONDecoder()
            let jsonDecoder = try? decoder.decode(LocationModel.self, from: data)
            DispatchQueue.main.async {
                complititon(jsonDecoder)
            }
    
        }.resume()
    }
    
    
}

//"https://api.weatherbit.io/v2.0/forecast/daily?&lat=49.8382600&lon=24.0232400&key=e52288a13981475ab48fd3acdd970940"

