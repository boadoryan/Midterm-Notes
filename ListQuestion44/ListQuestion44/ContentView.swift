//
//  ContentView.swift
//  ListQuestion44
//
//  Created by Ryan Boado on 2023-03-06.
//


//44. Implement an app that keeps track of one's favourite colours, similar to the one shown in Figure L-1. Pressing the + icon navigation button adds a new entry to the list with: 
//• a TextField (for holding a description) 
//• a ColorPicker (for holding the favourite colour) 
//Descriptions and colours can be changed at any time.


import SwiftUI

struct FavouriteColor: Identifiable {
    var id: UUID
    var colour: Color
    var desc: String
    
    init(clr: Color, description: String)
    {
        self.id = UUID()
        self.colour = clr
        self.desc = description
    }
}

class FavouriteColors: ObservableObject {
    @Published var favColors: [FavouriteColor]
    
    init ()
    {
        favColors = [FavouriteColor]()
    }
}

struct ContentView: View {
    
    //@State var color = Color.black
    @StateObject var favouriteColors = FavouriteColors()
    
    var body: some View {
        NavigationStack {
            List($favouriteColors.favColors) {
                $color in
                HStack {
                    TextField("Item", text: $color.desc)
                    ColorPicker("",selection: $color.colour)
                }
            } // end of list
            .navigationTitle("Color Picker")
            .navigationBarItems(
                trailing: Button(
                    action: {
                        withAnimation {
                            favouriteColors.favColors.insert(FavouriteColor(clr: .black, description: "Color:"), at: 0)
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
