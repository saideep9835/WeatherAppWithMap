//
//  WeatherViewModelWithThreeValues.swift
//  WeatherApp
//
//  Created by Saideep Reddy Talusani on 9/24/24.
//
import Foundation
class WeatherViewModelWithThreeValues{
    weak var delegateCodeWithThreeValues: WeatherDelegate?
    func weatherWithThreeValues(for state: String, for stateCode: Int, for countryCode: Int) async{
        
        guard let url = URL(string: Constants.weatherStateCodeUrl(for: state, for: stateCode, for: countryCode)) else {return}
        do{
            let weatherDataThreeValues: WeatherModel = try await WeatherAPIManager.shared.getWeatherData(url: url)
                delegateCodeWithThreeValues?.weatherFetched(weatherDataThreeValues)
            
        }catch{
            print("No Values")
        }
    }
}
