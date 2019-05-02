//
//  ViewController.swift
//  simple-weather
//
//  Created by egmars.janis.timma on 22/04/2019.
//  Copyright © 2019 egmars.janis.timma. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet var locationLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var weatherLabel: UILabel!
    @IBOutlet var tempLabel: UILabel!
    @IBOutlet var weatherImage: UIImageView!
    @IBOutlet var tableView: UITableView!
    
    var forecastWeatherArray: [ForecastWeather] = []
    
    let today = Date()
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        
        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
            locationManager.startUpdatingLocation()
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = " MMMM dd,  yyyy";
        let myDate = dateFormatter.string(from: Date.init())
        dateLabel.text = "Today, \(myDate)"
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        
        APIService().getData(coordinates: locValue) { (result) in
            switch result {
            case .success(let currentWeather):
                DispatchQueue.main.async {
                    self.locationLabel.text = currentWeather.location
                    self.tempLabel.text = NSString(format: "%.2f°C", currentWeather.temperature) as String
                    self.weatherLabel.text = currentWeather.weather
                    self.weatherImage.image = currentWeather.image
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        APIService().getDataForCell(coordinates: locValue) { (result) in
            switch result {
            case .success(let forecastWeather):
                DispatchQueue.main.async {
                    self.forecastWeatherArray = forecastWeather
                    var filteredForecast = [ForecastWeather]()
                    for index in 0 ..< forecastWeather.count {
                        let item = forecastWeather[index]
                        if filteredForecast.last?.weekDay != item.weekDay {
                            filteredForecast.append(item)
                        }
                    }
                    self.forecastWeatherArray = filteredForecast
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ForecastCell") as! ForecastCell
        let newValue = forecastWeatherArray[indexPath.row]
        cell.configureCell(forecastWeather: newValue)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecastWeatherArray.count
    }
}
