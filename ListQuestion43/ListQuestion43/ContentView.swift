//
//  ContentView.swift
//  ListQuestion43
//
//  Created by Ryan Boado on 2023-03-06.
//

import SwiftUI

struct ShoppingListItem: Identifiable {
    var id: UUID
    var item: String
    
    init(item: String)
    {
        self.id = UUID()
        self.item = item
    }
}

class ShoppingList: ObservableObject {
    @Published var shoppingList = [ShoppingListItem]()
    
    init ()
    {
        shoppingList = [ShoppingListItem]()
    }
}

struct ContentView: View {
    
    @StateObject var shoppingList = ShoppingList()
    
    var body: some View {
        NavigationStack { // NEED NAVIGATION STACK!
            List {
                ForEach($shoppingList.shoppingList) {
                    $item in
                    TextField("Item", text: $item.item)
                }
                .onDelete {
                    if let index = $0.first {
                        shoppingList.shoppingList.remove(at: index)
                    }
                }
            } // end of list
            .navigationTitle("Shopping List")
            .navigationBarItems(
                trailing: Button(
                    action: {
                        withAnimation {
                            shoppingList.shoppingList.insert(ShoppingListItem(item:""), at: 0)
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
