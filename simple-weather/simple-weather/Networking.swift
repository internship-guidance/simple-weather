//
//  Networking.swift
//  simple-weather
//
//  Created by egmars.janis.timma on 24/04/2019.
//  Copyright © 2019 egmars.janis.timma. All rights reserved.
//

import Foundation
import CoreLocation

enum NetworkError: Error {
    case badURL
}
struct APIService {
    
    func getData(coordinates: CLLocationCoordinate2D, completionHandler: @escaping (Result <CurrentWeather, NetworkError>) -> Void) {
        let jsonUrl = "http://api.openweathermap.org/data/2.5/weather?lat=\(coordinates.latitude)&lon=\(coordinates.longitude)&appid=4ec61b9764720fc34bc6123d2169ab81"
        
        guard let url = URL(string: jsonUrl) else {return}
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let dataResponse = data,
                error == nil else {
                    print(error?.localizedDescription ?? "Response Error")
                    return
            }
            
            do {
                //here dataResponse received from a network request
                let jsonResponse = try JSONSerialization.jsonObject(with:
                    dataResponse, options: [])
                
                guard let jsonArray = jsonResponse as? [String: Any] else {
                    return
                }
                
                guard let countryName = jsonArray ["name"] as? String else { return }
                
                if let tempObj = jsonArray["main"] as? [String: Any],
                    let temperature = tempObj ["temp"] as? Double {
                    let temperatureInCelsiusRaw = (temperature - 273.15)
                    let temperatureInCelsius = (round(1000*temperatureInCelsiusRaw)/1000)
                    
                    if let weatherMain = jsonArray ["weather"] as? [[String: Any]],
                        let weatherCondition = weatherMain[0]["main"] as? String {
                        
                        if let countrySymbols = jsonArray ["sys"] as? [String: Any],
                            let countrySymbol = countrySymbols["country"] as? String {
                            
                            let currentWeather = CurrentWeather(city: countryName, country: countrySymbol, _temperature: temperatureInCelsius, weather: weatherCondition)
                            
                            completionHandler(.success(currentWeather))
                        }
                    }
                }
            } catch let parsingError {
                print("Error", parsingError)
            }
        }
        task.resume()
    }
    
    func getDataForCell(coordinates: CLLocationCoordinate2D, completionHandler: @escaping (Result <[ForecastWeather], NetworkError>) -> Void) {
        let jsonUrlForCell = "http://api.openweathermap.org/data/2.5/forecast?lat=\(coordinates.latitude)&lon=\(coordinates.longitude)&appid=4ec61b9764720fc34bc6123d2169ab81"
        
        guard let url = URL(string: jsonUrlForCell) else {return}
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let dataResponse = data,
                error == nil else {
                    print(error?.localizedDescription ?? "Response Error")
                    return
            }
            do {
                //here dataResponse received from a network request
                let jsonResponse = try JSONSerialization.jsonObject(with:
                    dataResponse, options: [])
                
                guard let jsonArray = jsonResponse as? [String: Any] else {
                    return
                }
                
                var forecastWeatherArray: [ForecastWeather] = []
                
                if let weekDays = jsonArray["list"] as? [[String: Any]] {
                    for weekDay in weekDays {
                        if let date = weekDay["dt"] as? Double {
                            let date = Date(timeIntervalSince1970: date)
                            let dateFormatter = DateFormatter()
                            dateFormatter.dateFormat = "EEEE"
                            let dateIs = dateFormatter.string(from: date)
                            
                            if let weather = weekDay["weather"] as? [[String: Any]] {
                                if let currentCondition = weather[0]["main"] as? String {
                                    
                                    if let maxTemp = weekDay["main"] as? [String: Any] {
                                        if let maxTemperature = maxTemp["temp_max"] as? Double {
                                            let temperatureInCelsiusRaw = (maxTemperature - 273.15)
                                            let maxTemperatureInCelsius = (round(1000*temperatureInCelsiusRaw)/1000)
                                            
                                            if let minTemp = weekDay["main"] as? [String: Any] {
                                                if let minTemperature = minTemp["temp_min"] as? Double {
                                                    let temperatureInCelsiusRaw = (minTemperature - 273.15)
                                                    let minTemperatureInCelsius = (round(1000*temperatureInCelsiusRaw)/1000)
                                                    
                                                    let forecastWeather = ForecastWeather(weekDay: "\(dateIs)", maxTemp: maxTemperatureInCelsius, minTemp: minTemperatureInCelsius, weatherCondition: currentCondition, weatherPic: currentCondition)
                                                    
                                                    forecastWeatherArray.append(forecastWeather)
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                    completionHandler(.success(forecastWeatherArray))
                }
            } catch {
                print("Error", error)
            }
        }
        task.resume()
    }
}

