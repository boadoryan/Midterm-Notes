//
//  ContentView.swift
//  NavigationQ51
//
//  Created by Ryan Boado on 2023-03-04.
//

//51. Write a quiz app similar to the one shown in Figure N-1. There are 4 tabs, labelled "BC", "AB", "SK", and "MB". Each tab contains a picker, letting the user select among the capitals "Victoria", "Edmonton", "Regina", and "Winnipeg". If the user correctly matches the province and capital, a green checkmark appears. If there is a mismatch, a red X mark appears.

import SwiftUI

struct PickerView: View {
    var capitals: [String]
    var selectedProvince: String
    var correctAnswer: String
    
    @State var selectedCapital = "" // A value that gets passed in from ContentView()
    
    
    var body: some View {
        VStack {
            Text("The capital of \(selectedProvince) is:")
            Picker("Capitals", selection: $selectedCapital) {
                ForEach(capitals, id: \.self) { // Populate the picker with the values passed into capitals
                    capital in
                        Text(capital)
                }
            }.pickerStyle(WheelPickerStyle())
            
            // Conditional Rendering
            if selectedCapital == correctAnswer {
                Image(systemName: "checkmark")
                    .foregroundColor(.green)
            }
            else if selectedCapital != "" {
                Image(systemName: "xmark")
                    .foregroundColor(.red)
            }
        }
    }
}
struct ContentView: View {
    
    let provinces = ["","BC","AB","SK","MB"]
    let capitals = ["","Victoria","Edmonton","Regina","Winnipeg"]
    
    @State var selectedProvince = ""
    @State var selectedCapital = ""

    var body: some View {
        TabView(selection: $selectedProvince) {
            ForEach(1..<capitals.count) {
                index in // Index holds the current capital you are on.
                PickerView(capitals: capitals, selectedProvince: provinces[index], correctAnswer: capitals[index])
                    .tabItem {
                        Label(provinces[index], systemImage: "\(index).circle")
                    }
                    .tag(provinces[index])
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
