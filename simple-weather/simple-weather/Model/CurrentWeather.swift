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
    var city: String
    var country: String
    
    var location: String {
        get {
            return "\(city), \(country)"
        }
    }
    var _temperature: Double
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
}

