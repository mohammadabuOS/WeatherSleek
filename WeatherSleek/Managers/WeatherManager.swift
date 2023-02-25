//
//  WeatherManager.swift
//  WeatherSleek
//
//  Created by Mohammad Abuosbie on 2/25/23.
//

import Foundation
import CoreLocation
import WeatherKit

// WeatherKit API
@MainActor class WeatherManager: ObservableObject {
    
    @Published var weather: Weather?
    
    
    func getCurrentWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) async {
        do {
            weather = try await Task.detached(priority: .userInitiated) {
                return try await WeatherService.shared.weather(for: .init(latitude: latitude, longitude: longitude))
            }.value
        } catch {
            fatalError("\(error)")
        }
    }
    
    var symbol: String {
        weather?.currentWeather.symbolName ?? "xmark"
    }
    
    var temp: String {
        let temp =
        weather?.currentWeather.temperature
        
        let convert = temp?.converted(to: .fahrenheit).description
        return convert ?? "Loading Weather Data"
        
    }
    
}

/*
// OpenWeather API
class WeatherManager
{
    func getCurrentWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) async throws -> ResponseBody
    {
        guard let url = URL(string: "GET https://weatherkit.apple.com/api/v1/availability/\(latitude)}/\(longitude)")
        else {
            fatalError("Missing URL")
        }
        
        let urlRequest = URLRequest(url: url)
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200
        else {
            fatalError("Error fetching weather data")
        }
        
        let decodedData = try JSONDecoder().decode(ResponseBody.self, from: data)
        
        return decodedData
    }
}
*/
