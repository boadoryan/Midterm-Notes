//
//  ContentView.swift
//  ToDoListApp
//
//  Created by Ryan Boado on 2023-03-05.
//

import SwiftUI
import os

struct ToDoListItem: Identifiable, Codable {
    var id: UUID
    var item: String
    var taskDone: Bool
    
    init(item: String, done: Bool) {
        self.id = UUID()
        self.item = item
        self.taskDone = done
    }
}

class ToDoList: ObservableObject {
    @Published var item = [ToDoListItem]() // called in loadObjects()
    
    static let documentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
        static let entriesURL = documentsDirectory.appendingPathComponent("entries")

    // Look at this init
    init() {
        item = [ToDoListItem]() // Initialize an array of ToDoListItems
        loadObjects() // Call loadObjects
    }
    
    // loadObjects
    func loadObjects() {
        do {
            let data = try Data(contentsOf: ToDoList.entriesURL) // Matches with class 
            let decoder = JSONDecoder()
            item = try decoder.decode([ToDoListItem].self, from: data) // Matches with struct
        } catch {
            os_log("Cannot load due to %@", log: OSLog.default, type: .debug, error.localizedDescription)
        }
    } // end of loadObjects()
    
    // saveObjects
    func saveObjects() {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(item)
            try data.write(to: ToDoList.entriesURL)
        } catch {
            os_log("Cannot save due to %@", log: OSLog.default, type: .debug, error.localizedDescription)
        }
    } // end of saveObjects
}


struct ContentView: View {
    
    @EnvironmentObject var toDoList: ToDoList // Look at this
    
    var body: some View {
        NavigationStack {
            List {
                ForEach($toDoList.item) {
                    $item in
                    HStack {
                        TextField("Item", text: $item.item)
                        Toggle("Done", isOn: $item.taskDone)
                    }
                }
                .onDelete {
                    if let index = $0.first {
                        toDoList.item.remove(at:index)
                    }
                }w
            } // end of list
            .navigationBarTitle("To Do List")
            .navigationBarItems(
                trailing: Button(
                    action: {
                        withAnimation {
                            toDoList.item.insert(ToDoListItem(item:"", done: false), at: 0)
                        }
                    }
                ) {
                    Image(systemName: "plus")
                }
            ) // end of NavigationBarTitle
        } // end of NavigationStack
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ToDoList()) // Look here
    }
}

