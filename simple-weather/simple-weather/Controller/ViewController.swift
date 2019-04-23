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
    
    let today = Date()
    
    let locationManager = CLLocationManager()
    
    var currentWeather: CurrentWeather!

    let url = "https://samples.openweathermap.org/data/2.5/weather?lat=35&lon=139&appid=4ec61b9764720fc34bc6123d2169ab81"
    
//    struct Weather {
//
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM dd, yyyy";
        let myDate = dateFormatter.string(from: Date.init())
        dateLabel.text = "Today, \(myDate)"
        
//        let stringURL = NSURL(string: url)
//        let weatherObject = NSData(contentsOf: stringURL! as URL)
//        print(weatherObject)
//
//        currentWeather = CurrentWeather()
//        currentWeather.downloadCurrentWeather() {
//            print("Data is downloaded!!!")
//        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        locationLabel.text = "location\(locValue.latitude) \(locValue.longitude)"
    }
}

