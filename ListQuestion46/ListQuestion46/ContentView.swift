//
//  ContentView.swift
//  ListQuestion46
//
//  Created by Ryan Boado on 2023-03-04.
//


//46. Implement an app that keeps track of weather conditions, similar to the one shown in Figure L-3. Pressing the + icon navigation button adds a new entry to the list with: 
//• an Image (for displaying one of "sun.max", "cloud.sun", "cloud", "cloud.rain") 
//• a Slider (for changing the displayed icon) 
//Image and Slider values can be edited at any time.



import SwiftUI

struct WeatherCondition: Identifiable {
    var id: UUID
    var icon: Double
    
    init(icon: Double) {
        self.id = UUID()
        self.icon = icon
    }
}

class WeatherConditions: ObservableObject {
    @Published var weatherConditions: [WeatherCondition]
    
    init() {
        weatherConditions = [WeatherCondition]()
    }
}

struct ContentView: View {
    
    let icons = ["sun.max","cloud.sun","cloud","cloud.rain"]
    
    @StateObject var weatherConditions = WeatherConditions()
    
    var body: some View {
        NavigationStack {
            List($weatherConditions.weatherConditions) {
                $weather in
                HStack {
                    Image(systemName: icons[Int(weather.icon)])
                    Slider(value: $weather.icon, in: 0...Double(icons.count-1))
                    
                } // end of VStack
            } // end of list
            .navigationBarTitle("Weather Report")
            .navigationBarItems(
                trailing: Button(
                    action: {
                        withAnimation {
                            weatherConditions.weatherConditions.insert(WeatherCondition(icon:0), at: 0)
                        }
                    }
                ) {
                    Image(systemName: "plus")
                }
            ) // end of NavigationBarTitle
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

