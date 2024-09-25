//
//  weatherViewModel.swift
//  WeatherApp
//
//  Created by Saideep Reddy Talusani on 9/24/24.

import Foundation

protocol WeatherDelegate: AnyObject{
    func weatherFetched(_ weatherData: WeatherModel)
}
class WeatherViewModel{
    
    weak var delegate: WeatherDelegate?
    
    func fetchWeatherData(for city: String) async{
        guard let url = URL(string: Constants.weatherUrl(for: city)) else{return}
     
        do{
            let weather: WeatherModel = try await WeatherAPIManager.shared.getWeatherData(url: url)
            delegate?.weatherFetched(weather)
         
        }catch{
            print("Failed to fetch user: \(error.localizedDescription)")
        }
        
    }
}

extension WeatherViewModel{
    
}
