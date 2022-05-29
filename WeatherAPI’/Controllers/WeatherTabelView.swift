//
//  WeatherTabelView.swift
//  WeatherAPI’
//
//  Created by Andriy on 28.05.2022.
//

import UIKit

class WeatherTabelView: UITableViewController {
    
    var locatinModel: LocationModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.allowsSelection = false
        API()
    }
    
    func API() {
        WeatherNetwork.fetchWeather(location: Location.location) {  data in
            self.locatinModel = data
            self.tableView.reloadData()
        }
    }


    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CastomCell
        guard let weatherModel = locatinModel?.data[indexPath.row+1] else { return cell}
        cell.dataLabel.text = weatherModel.valid_date
        cell.tempLabel.text = "Temp:\(weatherModel.temp)˚C"
        cell.rainyLabel.text = "Rain:\(weatherModel.pop)%"
        cell.imagePhoto.image = UIImage(named: "\(weatherModel.weather.code)")
        return cell
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ((locatinModel?.data.count ?? 0)-1)
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }

}
