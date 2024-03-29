//
//  WeatherTabelView.swift
//  WeatherAPI’
//
//  Created by Andriy on 28.05.2022.
//

import UIKit

class WeatherTabelView: UITableViewController {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private var locationModel: LocationModel?
    private let request = Requests()
    private let location = Location.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
        tableView.allowsSelection = false
        setWeatherFor16Day()
    }
    
    func setWeatherFor16Day() {
        guard let coordinate = location.coordinate else { return print("No coordinates")}
        
        request.getWetherByCoordinate(coordinate) { data in
            self.locationModel = data
            self.activityIndicator.isHidden = true
            self.activityIndicator.stopAnimating()
            self.tableView.reloadData()
        }
    }


    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CastomCell
        guard let weatherModel = locationModel?.data[indexPath.row] else { return cell}
        cell.dataLabel.text = weatherModel.valid_date
        cell.tempLabel.text = "Temp:\(weatherModel.temp)˚C"
        cell.rainyLabel.text = "Rain:\(weatherModel.pop)%"
        cell.imagePhoto.image = UIImage(named: "\(weatherModel.weather.code)")
        return cell
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ((locationModel?.data.count ?? 0))
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }

}
