//
//  CurrentWeather.swift
//  simple-weather
//
//  Created by egmars.janis.timma on 23/04/2019.
//  Copyright © 2019 egmars.janis.timma. All rights reserved.
//

import Foundation
import UIKit

struct CurrentWeather {
    private var city: String
    private var country: String
    
    var location: String {
        get {
            return "\(city), \(country)"
        }
    }
    private var _temperature: Double = 0
    var temperature: Double {
        get {
            return _temperature
        }
        set {
            _temperature = newValue - 273.15
        }
    }
    
    var weather: String
    var image: UIImage? {
        return UIImage(named: weather)
    }
    
    init(city: String, country: String, temperature: Double, weather: String) {
        self.city = city
        self.country = country
        self.weather = weather
        self.temperature = temperature
    }
}

