//
//  WeatherTabelView.swift
//  WeatherAPI’
//
//  Created by Andriy on 28.05.2022.
//

import UIKit

class WeatherTabelView: UITableViewController {
    
    var locationModel: LocationModel?
    let request = Requests()
    let location = Location.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.allowsSelection = false
        setWeatherFor16Day()
    }
    
    func setWeatherFor16Day() {
        
        if location.coordinate != nil {
            request.getWetherByCoordinate(location.coordinate!) { data in
                self.locationModel = data
                self.tableView.reloadData()
            }
        } else {
            request.getWetherByCity(location.city) { data in
                self.locationModel = data
                self.tableView.reloadData()
            }
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
