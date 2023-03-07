//
//  ContentView.swift
//  Lab2_2023
//
//  Created by Ryan Boado on 2023-01-22.
//

import SwiftUI
import Photos

struct DetailView: View {
    
    // State Variables
    @State private var description = ""
    @State var pickerVisible = false
    @State var showCameraAlert = false
    @State var imageSource = UIImagePickerController.SourceType.camera
    @Binding var inventoryItem: InventoryItem
    
    @State var showLibraryAlert  = false
    
    // Binding Variables
    var maxChars: Int // Bound to SettingsView
    
    // Variables
    var colour: Color
    
    let backgroundColor = Color.white
    // Start of Body
    var body: some View {
        ZStack {
            VStack {
                Image(uiImage: inventoryItem.image)
                    .resizable(resizingMode: .stretch)
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
                    .border(inventoryItem.favourite ? colour : backgroundColor)
                    .accessibilityIdentifier("DetailImage")
                    .scaledToFit()
                    .gesture(TapGesture(count: 1).onEnded({ value in PHPhotoLibrary.requestAuthorization({ status in
                        if status == .authorized {
                            self.showLibraryAlert = false
                            self.imageSource = UIImagePickerController.SourceType.photoLibrary
                            self.pickerVisible.toggle()
                        } else {
                            self.showLibraryAlert = true
                        } })
                    }))
                Toggle(isOn: $inventoryItem.favourite) {
                    Text("Favourite")
                }
                .accessibilityIdentifier("FavouriteToggle")
                TextEditor(text: Binding(
                    get: {
                        inventoryItem.description
                    },
                    set: {
                        newValue in
                        if newValue.count <= maxChars {
                            inventoryItem.description = newValue
                        }
                    }
                )
                ).accessibilityIdentifier("DetailTextEditor")
                Text(String(inventoryItem.description.count) + " / " + String(maxChars)).accessibilityIdentifier("DetailText")
            }
            .navigationBarItems(trailing:
                                    Button(action: {
                AVCaptureDevice.requestAccess(for: AVMediaType.video) { response in
                    if response && UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) { self.showCameraAlert = false
                        self.imageSource = UIImagePickerController.SourceType.camera
                        self.pickerVisible.toggle()
                    } else {
                        self.showCameraAlert = true
                    } }
            }) {
                Image(systemName: "camera")
            }
                .alert(isPresented: $showCameraAlert) {
                    Alert(title: Text("Error"), message: Text("Camera not available"), dismissButton: .default(Text("OK"))) }
            )
            .padding()
        }
        if pickerVisible {
            ImageView(pickerVisible: $pickerVisible, sourceType: $imageSource, action: { (value) in
                if let image = value {
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()) {
                        self.imageSource = imageSource
                        self.inventoryItem.image = image
                    } }
            }) }
    }
}

// This is only for previews!
struct DetailView_Previews: PreviewProvider {
    @State static var maxChars = 150
    @State static var inventoryItem = InventoryItem(image:"medal",description:"lasso",favourite:false)
    @State static var favourite = false;
    
    static var previews: some View {
        DetailView(inventoryItem:$inventoryItem,maxChars: maxChars,colour: Color.yellow)
    }
}
