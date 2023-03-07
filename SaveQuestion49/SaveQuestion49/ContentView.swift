//
//  ContentView.swift
//  SaveQuestion49
//
//  Created by Ryan Boado on 2023-03-04.
//


//Implement an app similar to the one shown in Figure S-3, with:  • a TextField for a name and 
//• a DatePicker for a birthday 
//Pressing on Save saves the data 
//Pressing on Load loads the data.
                    
import SwiftUI

struct BirthdayTracker: Encodable, Decodable {
    var username: String
    var date: Date
}

struct ContentView: View {
    
    let archiveURL = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("userinfo")
    
    @State var username = ""
    @State var date = Date()
    
    var body: some View {
        VStack {
            TextField("Your name ", text: $username)
            DatePicker("Birthday", selection: $date)
            Button("Load", action: {
                let data = try? Data(contentsOf: archiveURL)
                if let d = data {
                    let decoder = JSONDecoder() // always need this
                    let user = (try? decoder.decode(BirthdayTracker.self, from: d)) ?? BirthdayTracker(username:"",date:Date())
                    username = user.username
                    date = user.date
                }
            }) // end of button
            Button("Save", action: {
                let encoder = JSONEncoder()
                let data = try? encoder.encode(BirthdayTracker(username: username, date: date))
                try? data?.write(to:archiveURL)
            })
        } // end of VStack
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
