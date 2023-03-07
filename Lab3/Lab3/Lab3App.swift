//
//  Lab3App.swift
//  Lab3
//
//  Created by Ryan Boado on 2023-01-24.
//

import SwiftUI

@main
struct Lab3App: App {
    @StateObject var inventoryItems = InventoryItems()
    @Environment(\.scenePhase) var scenePhase
    var body: some Scene {
        WindowGroup {
            //MainView()
            MainView().environmentObject(inventoryItems)
            
        }.onChange(of: scenePhase, perform: {
            phase in
            switch phase {
            case .background:
                inventoryItems.saveObjects()
            default:
    break }
    })
    }
}
