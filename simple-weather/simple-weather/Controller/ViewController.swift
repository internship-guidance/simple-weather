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
    
    
    let today = Date()
    
    let locationManager = CLLocationManager()
    
    let url = "http://api.openweathermap.org/data/2.5/weather?lat=24&lon=134&appid=4ec61b9764720fc34bc6123d2169ab81"
    
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
        dateFormatter.dateFormat = "MMMM dd, yyyy";
        let myDate = dateFormatter.string(from: Date.init())
        dateLabel.text = "Today, \(myDate)"
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        
        APIService().getData(coordinates: locValue) { (result) in
            switch result {
            case .success(let currentWeather):
                DispatchQueue.main.async {
                    self.locationLabel.text = ("\(currentWeather.cityName), \(currentWeather.countryType)")
                    self.tempLabel.text = "\(String(Int((currentWeather.currentTemp - 273.15))))°"
                    self.weatherLabel.text = currentWeather.weatherType
                    self.weatherImage.image = UIImage(named: currentWeather.weatherType)
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
        cell.configureCell(weekDay: "tomorrow", maxTemp: 20, minTemp: 10, weatherCondition: "Clear", weatherPic: "Clear Mini")
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
}
