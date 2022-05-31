//
//  ViewController.swift
//  WeatherAPI’
//
//  Created by Andriy on 25.05.2022.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    
    let locationManager = CLLocationManager()
    var locationModel: LocationModel?
    
    //MARK: @IBOutlet
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var imageWeather: UIImageView!
    @IBOutlet weak var windyLabel: UILabel!
    @IBOutlet weak var rainyLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var feelingTemperature: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        requestJson()
        startLocationManager()
    }
    
    func requestJson() {
        WeatherNetwork.fetchWeather(location: Location.location) { data in
            self.locationModel = data
            self.weatherUIToday()
        }
    }
    
    func weatherUIToday() {
        guard let weatherModel = locationModel?.data[0] else { return }
        locationLabel.text = locationModel?.city_name
        descriptionLabel.text = weatherModel.weather.description
        imageWeather.image = UIImage(named: "\(weatherModel.weather.code)")
        windyLabel.text = "\(weatherModel.wind_spd)m/c"
        rainyLabel.text = "\(weatherModel.pop)%"
        temperatureLabel.text = "\(weatherModel.temp)˚C"
        feelingTemperature.text = "\(weatherModel.app_max_temp)˚C"
    }
    
    func startLocationManager() {
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
            locationManager.pausesLocationUpdatesAutomatically = false
            locationManager.startUpdatingLocation()
        }
    }
    
    func createAlert() {
        let alertController = UIAlertController(title: "Впишіть своє місто по англійськи!", message: nil, preferredStyle: .alert)
        let actionCancel = UIAlertAction(title: "Відмінити!", style: .cancel)
        let actionDali = UIAlertAction(title: "Далі", style: .default) { [unowned self] action in
            guard let text = alertController.textFields?.first?.text else { return }
            Location.location = "city=\(text)"
            requestJson()
        }
        alertController.addTextField(configurationHandler: nil)
        alertController.addAction(actionCancel)
        alertController.addAction(actionDali)
        self.present(alertController, animated: true)
    }
    
    //MARK: @IBAction
    @IBAction func addCity(_ sender: Any) {
        createAlert()
    }
}

extension ViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let lastLocation = locations.first {
            Location.location = "lat=\(lastLocation.coordinate.latitude)&lon=\(lastLocation.coordinate.longitude)"
            requestJson()
        }
    }
}
