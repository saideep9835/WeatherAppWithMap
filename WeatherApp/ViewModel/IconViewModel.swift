//
//  IconViewModel.swift
//  WeatherApp
//
//  Created by Saideep Reddy Talusani on 9/24/24.
//

import Foundation

protocol IconDelegate: AnyObject {
    func didFetchIcon(_ iconData: Data)
}
class IconViewModel{
    
    weak var iconDelegate: IconDelegate?
    func fetchIcon(_ icon: String) async{
        guard let url = URL(string: "https://openweathermap.org/img/wn/\(icon)@2x.png") else{return}
        do{
            let icon = try await IconAPI.shared.getIcon(url: url)
            iconDelegate?.didFetchIcon(icon)
        }catch{
            print("Error fetching icon: \(error.localizedDescription)")
        }
    }
}
