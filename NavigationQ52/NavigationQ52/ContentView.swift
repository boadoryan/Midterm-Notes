//
//  ContentView.swift
//  NavigationQ52
//
//  Created by Ryan Boado on 2023-03-04.
//

import SwiftUI

struct SettingsView : View {
    
    // The reason why border needs to be a float and not a bool is because
    // border takes a value starting at 0 which means no border.
    @Binding var border: CGFloat // Changes value depending on what gets passed.
    @Binding var colour: Color // Changes value via ColorPicker.

    var body: some View {
        Toggle("ShowBorder", isOn: Binding ( // this binding sets the float value of border.
            get: {
                border != 0 // Sets isOn to true or false
            },
            set: {
                border = $0 ? 1 : 0 // Sets border(CGFloat) if the value coming in is true, set it to 1, else set it to 0.
            }))
        .multilineTextAlignment(.center)
        ColorPicker("Colour",selection: $colour) // This sets the value of color in ContentView()
        .padding()
        .background(
            Rectangle()
                .foregroundColor(.white))
    }
}

struct ContentView: View {
    @State var width: CGFloat = 0 // This value can be changed in SettingsView()!
    @State var color = Color.black // This value can be changed in SettingsView()!
    
    var body: some View {
        NavigationStack() {
            ZStack {
                Text("ICS 224")
                    .frame(width: 250, height: 25, alignment: .center)
                    .foregroundColor(color)
                    .border(color, width: width) // border takes a value of 1 or 0 !
            }
            // this sets the default values!!!!
            // 1. Set the border to 0 (false)
            // 2. Set the color to black.
            .navigationBarItems(trailing: NavigationLink(destination: SettingsView(border: $width, colour: $color), label: {
                Image(systemName: "gear")
            }))
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
