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
    
    let today = Date()
    
    let locationManager = CLLocationManager()
    
    let url = "http://api.openweathermap.org/data/2.5/weather?lat=24&lon=134&appid=4ec61b9764720fc34bc6123d2169ab81"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        APIService().getData(coordinates: locValue) { currentWeather in
            DispatchQueue.main.async {
                 self.locationLabel.text = currentWeather.cityName
                self.tempLabel.text = "\(String(Int((currentWeather.currentTemp - 273.15))))°"
                self.weatherLabel.text = currentWeather.weatherType
                
                self.weatherImage.image = UIImage(named: currentWeather.weatherType)
            }
        }
    }
}
