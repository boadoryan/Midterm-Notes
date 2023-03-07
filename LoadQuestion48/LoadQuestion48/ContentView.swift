//
//  ContentView.swift
//  LoadQuestion48
//
//  Created by Ryan Boado on 2023-03-04.
//


//48. Implement an app similar to the one shown in Figure S-2, with: 
//• a TextField for a user ID and 
//• a SecureField for a password; a SecureField is similar to a TextField, but the text is replaced by dots 
//Pressing on Save saves the data 
//Pressing on Load loads the data. To make sure the correct password is loaded, add a print statement to your loading code

import SwiftUI

struct LoginCredentials: Encodable, Decodable {
    var userID: String
    var password: String
}

struct ContentView: View {
    
    let archiveURL = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("credentials")
    
    @State var username = ""
    @State var password = ""
    
    var body: some View {
        VStack {
            TextField("Username", text: $username)
            SecureField("Password", text: $password)
            Button("Load", action: {
                let data = try? Data(contentsOf: archiveURL)
                if let d = data {
                    let decoder = JSONDecoder() // always need this
                    let login = (try? decoder.decode(LoginCredentials.self, from: d)) ?? LoginCredentials(userID:"",password:"")
                    username = login.userID
                    password = login.password
                    print(password)
                }
            }) // end of button
            Button("Save", action: {
                let encoder = JSONEncoder()
                let data = try? encoder.encode(LoginCredentials(userID: username, password: password))
                                     try? data?.write(to: archiveURL)
            }) // end of button
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
