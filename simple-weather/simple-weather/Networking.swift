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
                let jsonResponse = try JSONSerialization.jsonObject(with:
                    dataResponse, options: [])
                
                guard let jsonArray = jsonResponse as? [String: Any] else {
                    return
                }
                
                guard let countryName = jsonArray ["name"] as? String else { return }
                
                if let tempObj = jsonArray["main"] as? [String: Any],
                    let temperature = tempObj ["temp"] as? Double {
                    
                    if let weatherMain = jsonArray ["weather"] as? [[String: Any]],
                        let weatherCondition = weatherMain[0]["main"] as? String {
                        
                        if let countrySymbols = jsonArray ["sys"] as? [String: Any],
                            let countrySymbol = countrySymbols["country"] as? String {
                            
                            let currentWeather = CurrentWeather(city: countryName, country: countrySymbol, temperature: temperature, weather: weatherCondition)
                            
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
                        guard let dt = weekDay["dt"] as? Double else {
                            return
                        }
                        
                        let date = Date(timeIntervalSince1970: dt)
                        let tomorrow: Date? = Calendar.current.date(byAdding: .day, value: 1, to: date)
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "EEEE"
                        let tomorrowDate = dateFormatter.string(from: tomorrow ?? date)
                        
                        guard let weather = weekDay["weather"] as? [[String: Any]],
                            let currentCondition = weather[0]["main"] as? String else {
                                return
                        }
                        
                        guard let main = weekDay["main"] as? [String: Any],
                            let maxTemp = main["temp_max"] as? Double,
                            let minTemp = main["temp_min"] as? Double else {
                                return
                        }
                        
                        let forecastWeather = ForecastWeather.init(weekday: tomorrowDate, maxTemp: maxTemp, minTemp: minTemp, weatherCondition: currentCondition)
                        
                        forecastWeatherArray.append(forecastWeather)
                    }
                }
                
                completionHandler(.success(forecastWeatherArray))
            } catch {
                print("Error", error)
            }
        }
        task.resume()
    }
}

