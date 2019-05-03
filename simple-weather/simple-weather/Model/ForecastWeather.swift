//
//  ForecastWeather.swift
//  simple-weather
//
//  Created by egmars.janis.timma on 26/04/2019.
//  Copyright © 2019 egmars.janis.timma. All rights reserved.
//

import Foundation
import UIKit

struct ForecastWeather {
    
    var weekDay: String
    private var _maxTemp = 0.0
    var maxTemp: Double {
        get {
            return _maxTemp
        }
        set {
            _maxTemp = newValue - 273.15
        }
    }
    
    private var _minTemp = 0.0
    var minTemp: Double {
        get {
            return _minTemp
        }
        set {
            _minTemp = newValue - 273.15
        }
    }
    
    var weatherCondition: String
    var image: UIImage? {
        return UIImage(named: "\(weatherCondition) Mini")
    }
    
    init(weekday: String, maxTemp: Double, minTemp: Double, weatherCondition: String) {
        self.weekDay = weekday
        self.weatherCondition = weatherCondition
        self.minTemp = minTemp
        self.maxTemp = maxTemp
    }
}

