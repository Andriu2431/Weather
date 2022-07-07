//
//  APIJson.swift
//  WeatherAPI’
//
//  Created by Andriy on 25.05.2022.
//

import Foundation
import CoreLocation

class Requests {
    
    func createForecastDailyURLComponents() -> URLComponents {
        var component = URLComponents()
        component.scheme = "https"
        component.host = "api.weatherbit.io"
        component.path = "/v2.0/forecast/daily"
        return component
    }
    
    func getWetherByCoordinate(_ myLocation: CLLocation, complititon: @escaping (LocationModel?) -> ()) {
        var urlComponent = createForecastDailyURLComponents()
        
        let queryItemLat = URLQueryItem(name: "lat", value: "\(myLocation.coordinate.latitude)")
        let queryItemLon = URLQueryItem(name: "lon", value: "\(myLocation.coordinate.longitude)")
        let queryItemKey = URLQueryItem(name: "key", value: "fcf64b6e457c4425aa4585dea5ea415c")
        
        urlComponent.queryItems = [queryItemLat,queryItemLon,queryItemKey]
        let url = urlComponent.url
        
        guard let url = url else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error)
            }
            
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
    
    func getWetherByCity(_ city: String, complititon: @escaping (LocationModel?) -> ()) {
        var urlComponent = createForecastDailyURLComponents()
        
        let queryItemCity = URLQueryItem(name: "city", value: "\(city)")
        let queryItemKey = URLQueryItem(name: "key", value: "fcf64b6e457c4425aa4585dea5ea415c")
        
        urlComponent.queryItems = [queryItemCity,queryItemKey]
        let url = urlComponent.url
        
        guard let url = url else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error)
            }
            
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

//ToDo: read about query param, URLComponents, URLQueryItem, Define two ways of fetching data from server: by coordinates or by city name
//"https://api.weatherbit.io/v2.0/forecast/daily?&lat=49.8382600&lon=24.0232400&key=fcf64b6e457c4425aa4585dea5ea415c"

