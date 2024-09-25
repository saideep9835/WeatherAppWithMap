//
//  WeatherViewCode.swift
//  WeatherApp
//
//  Created by Saideep Reddy Talusani on 9/24/24.
//
import Foundation
class WeatherViewCode{
    weak var delegateCode: WeatherDelegate?
    func fetchWeatherDataCode(city: String, countryCode: Int) async{
        guard let url = URL(string: Constants.weatherCodeUrl(for: city, for: countryCode)) else{return}
        do{
            let weatherDataWithCode: WeatherModel = try await WeatherAPIManager.shared.getWeatherData(url: url)
                delegateCode?.weatherFetched(weatherDataWithCode)
        }catch{
            print("no data")
        }
    }
}
