//
//  MainView.swift
//  Lab2_2023
//
//  Created by Ryan Boado on 2023-01-22.
//

import SwiftUI

// if showSettings is true: show the SettingsView() view
// else show the DetailView() view
// Decalre a navigationBarItems
//      at the end: Button
//                      action/onClick: toggle the showSettings between true or false
//
struct MainView: View {
    
    @State private var showSettings = false // Determine wether or not to
    @State var colour = array2color(array: UserDefaults.standard.object(forKey: "BackgroundColour") as? [CGFloat] ?? color2array(colour: Color.yellow))
    @State var maxChars = UserDefaults.standard.object(forKey: "MaxCharacterCount") as? Int ?? 150
    @Environment(\.horizontalSizeClass) var sizeClass
    @EnvironmentObject var inventoryItems: InventoryItems
    
    var body: some View {
        NavigationStack() {
            VStack {
                if showSettings {
                    SettingsView(colour: $colour, maxChars: $maxChars)
                }
                else {
                    List($inventoryItems.entries) {
                        $inventoryItem in
                        NavigationLink(
                            destination: DetailView(inventoryItem: $inventoryItem, maxChars: maxChars, colour: colour)
                        ) {
                            RowView(inventoryItem: inventoryItem,colour:$colour)
                                .swipeActions(edge: .trailing) {
                                    Button(role: .destructive) {
                                        inventoryItems.entries.removeAll(where: { $0.id == inventoryItem.id})
                                    } label: {
                                        Label("Delete", systemImage: "trash")
                                    } }
                        }
                    } // end of list
                }
            }
            .navigationBarTitle(Text("Inventory"))
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    if !showSettings {
                        Button(
                            action: {
                                withAnimation {
                                    let item = InventoryItem(image: "ladybug", description: "Ladybug", favourite: false)
                                    inventoryItems.entries.insert(item, at: 0)
                                }
                            }
                        ){
                            Image(systemName: "plus")
                        }
                        .accessibilityIdentifier("PlusButton")
                    }
                } // end of ToolbarItem
                ToolbarItem(placement: .bottomBar) {
                    Button (
                        action: {
                            showSettings.toggle()
                        },
                        label: {
                            Image(systemName: showSettings ? "house" : "gear")
                        }
                    ).accessibilityIdentifier("NavigationButton")
                } // end of ToolbarItem
            } // end of toolbar
        } // end of NavigationStack()
    } // end of body
    
    struct MainView_Previews: PreviewProvider {
        static var previews: some View {
            //MainView()
            ForEach(["iPad (10th generation)", "iPhone 14 Pro"], id: \.self) { deviceName in
                MainView()
                    .previewDevice(PreviewDevice(rawValue: deviceName)).environmentObject(InventoryItems(previewMode: true))
            }
        }
    }
}
