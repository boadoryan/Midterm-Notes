//
//  ToDoListAppApp.swift
//  ToDoListApp
//
//  Created by Ryan Boado on 2023-03-05.
//

import SwiftUI

@main

struct ToDoListAppApp: App {
    @Environment(\.scenePhase) var scenePhase // look at this 
    @StateObject var toDoList = ToDoList() // look at this
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(toDoList) // look at this
        } // end of WindowGroup
        .onChange(of: scenePhase, perform: {
            phase in
            switch phase {
            case .background:
                toDoList.saveObjects() // look at this
            default:
                break
            }
        })
    }
}
