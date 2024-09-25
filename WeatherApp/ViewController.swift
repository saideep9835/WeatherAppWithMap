//
//  ViewController.swift
//  WeatherApp
//
//  Created by Saideep Reddy Talusani on 9/24/24.
//

import UIKit
import MapKit

class ViewController: UIViewController, WeatherDelegate, IconDelegate {
    
    @IBOutlet weak var countryCode: UITextField!
    @IBOutlet weak var stateCode: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var searchTF: UITextField!
    
    @IBOutlet weak var stateName: UILabel!
    
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var temparature: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var getDetailsButton: UIButton!
    
    var mapView: MKMapView!
    
    let weatherService = WeatherViewModel()
    let weatherWithCountryCode = WeatherViewCode()
    let iconView = IconViewModel()
    let weatherWithThreeValues = WeatherViewModelWithThreeValues()
    override func viewDidLoad() {
        super.viewDidLoad()
        weatherService.delegate = self
        iconView.iconDelegate = self
        intialSetup()
        searchTF.accessibilityIdentifier = "cityTextField"
            stateCode.accessibilityIdentifier = "stateCodeTextField"
            countryCode.accessibilityIdentifier = "countryCodeTextField"
            stateName.accessibilityIdentifier = "stateNameLabel"
            countryLabel.accessibilityIdentifier = "countryLabel"
            temparature.accessibilityIdentifier = "temperatureLabel"
            descriptionLabel.accessibilityIdentifier = "descriptionLabel"
            imageView.accessibilityIdentifier = "weatherIconImageView"
        getDetailsButton.accessibilityIdentifier = "button"
       
    }
    func intialSetup(){
        let mapFrame = CGRect(x: 50, y: 550, width: 300, height: 300)
        mapView = MKMapView(frame: mapFrame)
        
       
        self.view.addSubview(mapView)
    }
    
    @IBAction func getDetailsButton(_ sender: UIButton) {
        guard let city = searchTF.text, !city.isEmpty else{return print("Please enter a city")}
        
        guard let stateCode = stateCode.text, !stateCode.isEmpty || stateCode.isEmpty else{return print("Please enter a state code")}
        guard let countryCode = countryCode.text, !countryCode.isEmpty || countryCode.isEmpty else{return print("Please enter a Country code")}
       
        Task{
            await weatherService.fetchWeatherData(for: city)
            await weatherWithCountryCode.fetchWeatherDataCode(city: city, countryCode: Int(countryCode) ?? 0)
            await weatherWithThreeValues.weatherWithThreeValues(for: city, for: Int(stateCode) ?? 0, for: Int(countryCode) ?? 0)
            
        }
        

    }
    
    // Function to pin a location on the map using latitude and longitude
        func pinLocationOnMap(location: CLLocationCoordinate2D, title: String) {
            let annotation = MKPointAnnotation()
            annotation.coordinate = location
            annotation.title = title
            mapView.addAnnotation(annotation)
        }
        
        // Function to center the map on the pinned location
        func centerMapOnLocation(_ location: CLLocationCoordinate2D) {
            let regionRadius: CLLocationDistance = 10000 // Radius in meters
            let coordinateRegion = MKCoordinateRegion(center: location, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
            mapView.setRegion(coordinateRegion, animated: true)
        }
    
    func didFetchIcon(_ iconData: Data) {
            DispatchQueue.main.async {
                // Convert the raw Data to UIImage and display it in the UIImageView
                if let image = UIImage(data: iconData) {
                    self.imageView.image = image
                } else {
                    print("Failed to convert data to image")
                }
            }
        }
    func weatherFetched(_ weatherData: WeatherModel) {
        print(weatherData)
        DispatchQueue.main.async {
            
            // Safely unwrap state name
                    guard let stateName = weatherData.name else {
                        self.stateName.text = "State not available"
                        return
                    }
                    self.stateName.text = "Name of State: \(stateName)"
                    
                    // Safely unwrap country
                    if let country = weatherData.sys?.country {
                        self.countryLabel.text = "Country: \(country)"
                    } else {
                        self.countryLabel.text = "Country not available"
                    }
                    
                    // Safely unwrap temperature
                    if let temperature = weatherData.main?.temp {
                        self.temparature.text = "Temperature: \(temperature)°C"
                    } else {
                        self.temparature.text = "Temperature not available"
                    }
                    
                    // Safely unwrap weather description
                    let description = weatherData.weather?.first?.description ?? "No Description"
                    self.descriptionLabel.text = "Description: \(description.capitalized)"
            
            if let iconCode = weatherData.weather?.first?.icon {
                            Task {
                                await self.iconView.fetchIcon(iconCode) // Call to fetch the icon
                            }
                        }
            let location = CLLocationCoordinate2D(latitude: weatherData.coord?.lat ?? 0, longitude: weatherData.coord?.lon ?? 70.00)
            
            // Pin the location on the map
            self.pinLocationOnMap(location: location, title: stateName)
            
            // Optionally: Center the map on the pinned location
            self.centerMapOnLocation(location)
                }
                
            
        }
    }
    
    
    
    
    


