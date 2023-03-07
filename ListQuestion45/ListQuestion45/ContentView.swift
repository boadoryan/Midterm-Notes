//
//  ContentView.swift
//  ListQuestion45
//
//  Created by Ryan Boado on 2023-03-06.
//
//45. Implement an app that keeps track of weather conditions, similar to the one shown in Figure L-2. Pressing the + icon navigation button adds a new entry to the list with: 
//• a TextField (for holding a location) 
//• a Picker (for holding the current weather condition) 
//Location and weather conditions can be edited at any time.

import SwiftUI

struct Weather: Identifiable {
    var id: UUID
    var desc: String // holds value of textfield
    var item: String // holds the value of whats selected in the picker
    
    init(description: String, item: String) {
        id = UUID()
        self.item = item
        self.desc = description
    }
}

class WeatherConditions: ObservableObject {
    @Published var weatherConditions = [Weather]()
    
    init ()
    {
        weatherConditions = [Weather]()
    }
}

struct ContentView: View {
    
    @StateObject var currWeather = WeatherConditions()
    let weatherIcons = ["sun.max", "cloud.sun", "cloud", "cloud.rain"]
    
    var body: some View {
        NavigationStack {
            List($currWeather.weatherConditions) {
                $weather in
                HStack {
                    TextField("", text: $weather.desc)
                    Picker("", selection: $weather.item) {
                        ForEach(weatherIcons, id: \.self) {
                            icon in
                            Image(systemName: icon)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
            } // end of list
            .navigationTitle("Weather Conditions")
            .navigationBarItems(
                trailing: Button(
                    action: {
                        withAnimation {
                            currWeather.weatherConditions.insert(Weather(description: "", item: ""), at: 0)
                        }
                    }
                ) {
                    Image(systemName: "plus")
                }
            ) // end of NavigationBarTitle
        } // end of navigation stack
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
