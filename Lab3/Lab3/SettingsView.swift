//
//  SettingsView.swift
//  Lab2_2023
//
//  Created by Ryan Boado on 2023-01-22.
//

import SwiftUI

struct SettingsView: View {
    @Binding var colour: Color
    @Binding var maxChars: Int
    
    let range = 10...300
    let step = 10
    
    var body: some View {
        VStack {
            ColorPicker("Background", selection: Binding(
                get: {
                    colour
                },
                set:{
                    newValue in
                    colour = newValue
                    UserDefaults.standard.set(color2array(colour: colour), forKey:
                       "BackgroundColour")
                })).accessibilityIdentifier("BackgroundColorPicker")
            Stepper(value: Binding(
                get: {
                    maxChars
                },
                set: {
                    newValue in // new value is placed in here every time the stepper increments or decrements.
                    maxChars = newValue // put the newValue into maxChars **only in scope in this set!**
                    UserDefaults.standard.set(maxChars, forKey: "MaxCharacterCount") // Save this setting under the key "MaxCharacterCount", passing in the scoped value of maxChars
                }

            ), in: range, step:step) {
                Text("Max Character Count: \(maxChars)")
            }.accessibilityIdentifier("MaxCountStepper")
        }.padding()
    }
}

func color2array(colour: Color) -> [CGFloat] {
       let uiColor = UIColor(colour)
       var red: CGFloat = 0.0
       var green: CGFloat = 0.0
       var blue: CGFloat = 0.0
       var alpha: CGFloat = 0.0
       uiColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
       return [red, green, blue, alpha]
}

func array2color(array: [CGFloat]) -> Color {
        return Color(Color.RGBColorSpace.sRGB, red: array[0], green: array[1], blue: array[2], opacity:
array[3]) }


//
//struct SettingsView_Previews: PreviewProvider {
//    @State static var colour = Color.yellow
//    @State static var maxChars = 150
//    static var previews: some View {
//        SettingsView(colour: $colour, maxChars: $maxChars)
//    }
//}
