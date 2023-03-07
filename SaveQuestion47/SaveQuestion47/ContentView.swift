//
//  ContentView.swift
//  SaveQuestion47
//
//  Created by Ryan Boado on 2023-03-04.
//

//47. Implement an app similar to the one shown in Figure S-1, with: 
//• a TextField for a phone number and 
//• a Toggle to track whether or not the phone number is a mobile number  Pressing on Save saves the data 
//Pressing on Load loads the data.

import SwiftUI


struct PhoneNumber: Encodable, Decodable {
    var phoneNumber: String
    var mobile: Bool
    
}
struct ContentView: View {
    
    let archiveURL = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("entries")
    
    @State var phoneNo = ""
    @State var isMobile = false
    
    var body: some View {
        VStack {
            TextField("Enter your phone number", text: $phoneNo)
            Toggle("Mobile", isOn: $isMobile)
            
            Button("Load", action: {
                let data = try? Data(contentsOf: archiveURL)
                if let d = data {
                    let decoder = JSONDecoder()
                    let contact = (try? decoder.decode(PhoneNumber.self,
                                                       from: d)) ?? PhoneNumber(phoneNumber: "", mobile: false)
                    phoneNo = contact.phoneNumber
                    isMobile = contact.mobile
                }
            }) // end of button
            Button("Save", action: {
                let encoder = JSONEncoder()
                let data = try? encoder.encode(PhoneNumber(phoneNumber: phoneNo, mobile: isMobile))
                                     try? data?.write(to: archiveURL)
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


