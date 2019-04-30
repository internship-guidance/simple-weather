//
//  ForecastCell.swift
//  simple-weather
//
//  Created by egmars.janis.timma on 25/04/2019.
//  Copyright © 2019 egmars.janis.timma. All rights reserved.
//

import UIKit

class ForecastCell: UITableViewCell {
    
    @IBOutlet var forecastPic: UIImageView!
    @IBOutlet var forecastWeather: UILabel!
    @IBOutlet var forecastMinTemp: UILabel!
    @IBOutlet var forecastMaxTemp: UILabel!
    @IBOutlet var forecastDay: UILabel!
    
    func configureCell(forecastWeather: ForecastWeather) {
        self.forecastWeather.text = forecastWeather.weatherCondition
        self.forecastDay.text = forecastWeather.weekDay
        self.forecastPic.image = forecastWeather.image
        self.forecastMinTemp.text = NSString(format: "%.2f°C", forecastWeather.minTemp) as String
        self.forecastMaxTemp.text = NSString(format: "%.2f°C", forecastWeather.maxTemp) as String
    }
}
