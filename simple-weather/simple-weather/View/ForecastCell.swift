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

    func configureCell(weekDay: String, maxTemp: Int, minTemp: Int, weatherCondition: String, weatherPic: String) {
        self.forecastDay.text = weekDay
        self.forecastMaxTemp.text = "\(maxTemp)"
        self.forecastMinTemp.text = "\(minTemp)"
        self.forecastWeather.text = weatherCondition
        self.forecastPic.image = UIImage(named: weatherPic)
    }
}
