//
//  ViewController.swift
//  WeatherAPI’
//
//  Created by Andriy on 25.05.2022.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: @IBOutlet
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var imageWeather: UIImageView!
    @IBOutlet weak var windyLabel: UILabel!
    @IBOutlet weak var rainyLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var feelingTemperature: UILabel!
    
    let url = "https://api.weatherbit.io/v2.0/forecast/daily?&lat=49.8382600&lon=24.0232400&key=e52288a13981475ab48fd3acdd970940"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weatherToday()
    }
    
    func weatherToday() {
        APIJson.fetchJson(url: url) { [unowned self] data in
            self.locationLabel.text = data?.city_name
            self.imageWeather.image = UIImage(named: String((data?.data[0].weather.code)!))
            self.windyLabel.text = String("\((data?.data[0].wind_spd)!)" + "m/c")
            self.rainyLabel.text = String("\((data?.data[0].pop)!)" + "%")
            self.temperatureLabel.text = String("\((data?.data[0].temp)!)" + "˚C")
            self.feelingTemperature.text = String("\((data?.data[0].app_max_temp)!)" + "˚C")
        }
    }
    
    
    
}

