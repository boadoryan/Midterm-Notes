//
//  ContentView.swift
//  NavigationQ53
//
//  Created by Ryan Boado on 2023-03-05.
//


//Implement an app similar to the one shown in Figure N-3. Pressing the gear icon navigation button brings up a settings view with: 
//• a Picker to pick the icon to be displayed on the main screen. To declare the UI element, use: 
//Picker("Weather", selection: $iconName) { 
//ForEach(icons, id: \.self) { icon in 
//Image(systemName: icon)  } 
//} 
//where iconName is a String that contains/will contain the name of the selected icon, and icons is the array ["sun.max", "cloud.sun", "cloud", "cloud.rain"] 
//• a Slider to pick the icon size. To declare the UI element, use: Slider(value: $size, in: 10...100) where size is of type CGFloat

import SwiftUI
struct SettingsView : View {
    
    let icons = ["sun.max","cloud.sun","cloud","cloud.rain"] // all icons to be rendered
    @Binding var iconName: String // Displayed in ContentView(), can be modified here

    var body: some View {
        Picker("Weather", selection: $iconName) {
            ForEach(icons, id: \.self) { icon in
                Image(systemName: icon)  }
        }
    }
}

struct ContentView: View {
    
    @State var iconName = ""

    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
