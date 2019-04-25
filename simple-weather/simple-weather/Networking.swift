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
        print(jsonUrl)
        
        
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
                print(jsonResponse) //Response result
                
                guard let jsonArray = jsonResponse as? [String: Any] else {
                    return
                }
                print(jsonArray)
                
                guard let countryName = jsonArray ["name"] as? String else { return }
                print("The city name is -> \(countryName)")
                
                if let tempObj = jsonArray["main"] as? [String: Any],
                    let temperature = tempObj ["temp"] as? Double {
                    print ("current temperature is -> \(temperature)")
                    
                    if let weatherMain = jsonArray ["weather"] as? [[String: Any]],
                        let weatherCondition = weatherMain[0]["main"] as? String {
                        print ("Current weather type is -> \(weatherCondition)")
                    
                        if let countrySymbols = jsonArray ["sys"] as? [String: Any],
                            let countrySymbol = countrySymbols["country"] as? String {
                            print("Current country is -> \(countrySymbol)")
                        
                        let currentWeather = CurrentWeather(cityName: countryName, weatherType: weatherCondition, currentTemp: temperature, countryType: countrySymbol)
                    
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
}
