//
//  IconAPI.swift
//  WeatherApp
//
//  Created by Saideep Reddy Talusani on 9/24/24.
//

import Foundation
import UIKit
class IconAPI{
    
    static let shared = IconAPI()
    private init() { }
    
    func getIcon(url: URL) async throws -> Data{
        let (data, response) = try await URLSession.shared.data(from:url)
        guard response is HTTPURLResponse
            else {
                    throw NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid Response"])
                }
        return data
        
    }
}
