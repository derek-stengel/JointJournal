//
//  ImagePickerView.swift
//  JointJournal
//
//  Created by Derek Stengel on 10/22/24.
//


import SwiftUI
import PhotosUI

struct ImagePickerView: View {
    @Binding var selectedImage: Image?
    @Binding var isPresented: Bool
    @Binding var imageAlertMessage: String
    @Binding var showImageAlert: Bool
    
    @State private var selectedItem: PhotosPickerItem? = nil
    
    var body: some View {
        PhotosPicker(selection: $selectedItem, matching: .images) {
            Text("Select an image")
        }
        .onChange(of: selectedItem) { newItem in
            loadImage(from: newItem)
        }
    }
    
    private func loadImage(from item: PhotosPickerItem?) {
        guard let item = item else { return }
        item.loadTransferable(type: Data.self) { result in
            if case .success(let data) = result, let data = data, let uiImage = UIImage(data: data) {
                selectedImage = Image(uiImage: uiImage)
                isPresented = false // Dismiss the sheet
                
                // Set alert message and show the alert with a delay
                imageAlertMessage = "Image successfully imported!"
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    showImageAlert = true
                }
            }
        }
    }
}
