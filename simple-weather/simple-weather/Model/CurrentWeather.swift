//
//  CurrentWeather.swift
//  simple-weather
//
//  Created by egmars.janis.timma on 23/04/2019.
//  Copyright © 2019 egmars.janis.timma. All rights reserved.
//

import Foundation

class CurrentWeather {
    
    private var _cityName: String!
    private var _date: String!
    private var _weatherType: String!
    private var _currentTemp: Double!
    
    
    var cityName: String {
        if _cityName == nil {
            _cityName = ""
        }
        return _cityName
    }
    
    var date: String {
        if _date == nil {
            _date = ""
        }
        return _date
    }
    
    var weatherType: String {
        if _weatherType == nil {
            _weatherType = ""
        }
        return _weatherType
    }
    
    var currentTemp: Double {
        if _currentTemp == nil {
            _currentTemp = 0.0
        }
        return _currentTemp
    }
    
//    func downloadCurrentWeather() {
//        print("not yet")
//    }
    
    
}
