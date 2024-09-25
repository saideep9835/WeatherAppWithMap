//
//  Constants.swift
//  WeatherApp
//
//  Created by Saideep Reddy Talusani on 9/24/24.
//

enum Constants: String{
    
    case apiKey = "73fbd1df0209b08c5a1b8645f5697d0f"
    case weather = "https://api.openweathermap.org/data/2.5/weather?q="
    
    static func weatherUrl(for city: String) -> String {
           return "\(Constants.weather.rawValue)\(city)&appid=\(Constants.apiKey.rawValue)"
        }
    
    static func weatherCodeUrl(for city: String, for countryCode: Int) -> String{
        return "\(Constants.weather.rawValue)\(city),\(countryCode)&appid=\(Constants.apiKey.rawValue)"
    }
    
    static func weatherStateCodeUrl(for state: String, for stateCode: Int, for countryCode: Int) -> String{
        return "\(Constants.weather.rawValue)\(state),\(stateCode),\(countryCode)&appid=\(Constants.apiKey.rawValue)"
    }
    
    
}
