//
//  ContentView.swift
//  WeatherSleek
//
//  Created by Mohammad Abuosbie on 2/25/23.
//

import SwiftUI
import WeatherKit

struct ContentView: View {
    @StateObject var locationManager = LocationManager()
    //var weatherManager = WeatherManager()
    @ObservedObject var weatherManager = WeatherManager()
    @State var weather: Weather?
    
    var body: some View {
        VStack {
            
            if let location = locationManager.location {
                Text("Coordinates: \(location.longitude), \(location.latitude)")
                LoadingView()
                    .task {
                        await weatherManager.getCurrentWeather(latitude: location.latitude, longitude: location.longitude)
                    }
            }
            
            else {
                if locationManager.isLoading {
                    LoadingView()
                }
                
                else {
                    WelcomeView()
                        .environmentObject(locationManager)
                }
            }
        }
        .background(Color(hue: 0.7, saturation: 0.75, brightness: 0.35))
        .preferredColorScheme(.dark)
        //.padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
