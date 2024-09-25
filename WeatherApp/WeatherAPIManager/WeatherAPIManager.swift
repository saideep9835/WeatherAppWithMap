//
//  WeatherAPIManager.swift
//  WeatherApp
//
//  Created by Saideep Reddy Talusani on 9/24/24.
//

import Foundation

class WeatherAPIManager {
    
    static let shared = WeatherAPIManager()
    
    private init() { }
    
    func getWeatherData<T: Codable>(url: URL) async throws -> T{
        let (data,response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse else {
                throw NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid Response"])
            }
        guard (200..<300).contains(httpResponse.statusCode) else {
            throw NSError(domain: "", code: httpResponse.statusCode, userInfo: [NSLocalizedDescriptionKey: "Invalid Response"])
        }
       
        // Decode the data
        do {
            let decodedData = try JSONDecoder().decode(T.self, from: data)
            return decodedData
        } catch {
            throw error
        }
        
    }
}
