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

    let url = "http://api.openweathermap.org/data/2.5/weather?lat=24&lon=134&appid=4ec61b9764720fc34bc6123d2169ab81"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
        
        locationLabel.text = url
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM dd, yyyy";
        let myDate = dateFormatter.string(from: Date.init())
        dateLabel.text = "Today, \(myDate)"
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        let jsonUrl = "http://api.openweathermap.org/data/2.5/weather?lat=\(locValue.latitude)&lon=\(locValue.longitude)&appid=4ec61b9764720fc34bc6123d2169ab81"
        print(jsonUrl)
        
        //fetchCurrentWeather
    }
    // {}
    
    //getData {url request -> response -> initialize currentWeather object -> set into viewControllerCurrentWeather variable}
}

