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
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configureCell(weekDay: String, maxTemp: Int, minTemp: Int, weatherCondition: String) {
        self.forecastDay.text = weekDay
        self.forecastMaxTemp.text = "\(maxTemp)"
        self.forecastMinTemp.text = "\(minTemp)"
        self.forecastWeather.text = weatherCondition
//        self.forecastPic.image = weatherPic(named: "Clear")
}
}
