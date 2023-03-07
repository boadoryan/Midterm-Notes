//
//  ContentView.swift
//  NavigationQ55
//
//  Created by Ryan Boado on 2023-03-05.
//

import SwiftUI

let pencil = "pencil.tip"
let brush = "paintbrush"

struct ContentView: View {
    
    enum Tab {
        case shape
        case palette
        case test
    }
    
    @State var selection: Tab = .shape
    var icons = ["", pencil, brush]
    @State var shape = ""
    @State var r = 0.0
    @State var g = 0.0
    @State var b = 0.0
    
    
    var body: some View {
        TabView(selection: $selection) {
            VStack {
                Picker("Shape", selection: $shape) {
                    ForEach(icons, id: \.self) {
                        icon in
                        Image(systemName:icon)
                    } // end of ForEach
                } // end of Picker
            } // end of VStack
            .padding()
            .tabItem {
                Text("Shape")
            }
            .tag(Tab.shape) // end of Shape tab
            
            VStack { // setting up all the sliders
                HStack {
                    Text("Red")
                        .frame(width: 50, height: 50, alignment: .trailing)
                    Slider(value:$r, in: 0...1)
                }
                HStack {
                    Text("Green")
                        .frame(width: 50, height: 50, alignment: .trailing)
                    Slider(value:$g, in: 0...1)
                }
                HStack {
                    Text("Blue")
                        .frame(width: 50, height: 50, alignment: .trailing)
                    Slider(value:$b, in: 0...1)
                }
            } // end of VStack
            .padding()
            .tabItem {
                Text("Colour")
            }
            .tag(Tab.palette) // end of Colour tab
            VStack {
                if shape == pencil {
                    Image(systemName: "circle.fill")
                        .resizable()
                        .frame(width: 20, height: 20, alignment: .center)
                        .foregroundColor(Color.init(red:r, green:g, blue: b,opacity:1))
                } // end of if
                else if shape == brush {
                    Image(systemName: "circle.fill")
                        .resizable()
                        .frame(width: 100, height: 100, alignment:.center)
                        .foregroundColor(Color.init(red:r,green:g,blue:b,opacity: 1))
                }
            }
            .padding()
            .tabItem {
                Text("Test")
            }
            .tag(Tab.test) // end of Test tab
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
