//
//  ViewController.swift
//  WeatherAPI’
//
//  Created by Andriy on 25.05.2022.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    
    //MARK: @IBOutlet
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var imageWeather: UIImageView!
    @IBOutlet weak var windyLabel: UILabel!
    @IBOutlet weak var rainyLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var feelingTemperature: UILabel!
    
    private let locationManager = CLLocationManager()
    private var locationModel: LocationModel?
    private let request = Requests()
    private var location = Location.shared
    private let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startLocationManager()
        
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Search city"
        navigationItem.searchController = searchController
    }
    
    
    func setWetherByCoordinate() {
        guard let coordinate = location.coordinate else { return print("No coordinates")}
        
        request.getWetherByCoordinate(coordinate) { data in
            self.locationModel = data
            self.appdateUI()
        }
    }
    
    func appdateUI() {
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
    
    func geocoder(city: String, complititon: @escaping (CLPlacemark?) -> ()) {
        let geocoder = CLGeocoder()
        
        geocoder.geocodeAddressString(city) { placemarks, error in
            
            if let error = error {
                print("Error", error)
            }
            
            let placemark = placemarks?.first
            complititon(placemark)
        }
    }
}

extension ViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let lastLocation = locations.first {
            location.coordinate = lastLocation
            setWetherByCoordinate()
        }
    }
}

extension ViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let searchTextFieldString = searchController.searchBar.searchTextField.text else { return }
        
        geocoder(city: searchTextFieldString) { [unowned self] placemark in
            self.location.coordinate = placemark?.location
            self.setWetherByCoordinate()
        }
        
        searchController.isActive = false
    }
}
