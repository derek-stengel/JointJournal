//
//  ImagePickerView.swift
//  JointJournal
//
//  Created by Derek Stengel on 10/22/24.
//

import SwiftUI
import PhotosUI

struct ImagePickerView: View {
    @Binding var selectedImages: [UIImage] // Change to array of UIImage
    @Binding var isPresented: Bool
    @Binding var imageAlertMessage: String
    @Binding var showImageAlert: Bool
    
    @State private var selectedItem: PhotosPickerItem? = nil
    
    var body: some View {
        PhotosPicker(
            selection: $selectedItem,
            matching: .images,
            photoLibrary: .shared()) {
                VStack(spacing: 10) {
                    Text("Select a photo")
                        .padding()
                        .background(Color(.blue))
                        .foregroundColor(.white)
                        .cornerRadius(18)
                        .padding()
                    Text("Note: After pressing the desired media, swipe this screen down (if needed), and if the photo is imported, a message will display while you type the rest of your journal entry. (It may take a moment)")
                        .foregroundColor(.gray)
                }
                .padding()
            }
            .onChange(of: selectedItem) { newItem in
                loadImage(from: newItem)
            }
    }
    
    private func loadImage(from item: PhotosPickerItem?) {
        guard let item = item else { return }
        item.loadTransferable(type: Data.self) { result in
            if case .success(let data) = result, let data = data, let uiImage = UIImage(data: data) {
                selectedImages.append(uiImage) // Append to selectedImages array
                isPresented = false
                
                imageAlertMessage = "Image successfully imported!"
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    showImageAlert = true
                }
            }
        }
    }
}


//import SwiftUI
//import PhotosUI
//
//struct ImagePickerView: View {
//    @Binding var selectedImage: Image?
//    @Binding var isPresented: Bool
//    @Binding var imageAlertMessage: String
//    @Binding var showImageAlert: Bool
//    
//    var completion: ((Image) -> Void)?
//    
//    @State private var selectedItem: PhotosPickerItem? = nil
//    
//    var body: some View {
//        PhotosPicker(
//            selection: $selectedItem,
//            matching: .images,
//            photoLibrary: .shared()) {
//                VStack(spacing: 10) {
//                    Text("Select a photo")
//                        .padding()
//                        .background(Color(.blue))
//                        .foregroundColor(.white)
//                        .cornerRadius(18)
//                        .padding()
//                    Text("Note: After pressing the desired media, swipe this screen down (if needed), and if the photo is imported, a message will display while you type the rest of your journal entry. (It may take a moment)")
//                        .foregroundColor(.gray)
//                }
//                .padding()
//            }
//            .onChange(of: selectedItem) { newItem in
//                loadImage(from: newItem)
//            }
//    }
//    
//    private func loadImage(from item: PhotosPickerItem?) {
//        guard let item = item else { return }
//        item.loadTransferable(type: Data.self) { result in
//            if case .success(let data) = result, let data = data, let uiImage = UIImage(data: data) {
//                selectedImage = Image(uiImage: uiImage)
//                isPresented = false // Dismiss sheet
//                
//                imageAlertMessage = "Image successfully imported!"
//                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//                    showImageAlert = true
//                }
//            }
//        }
//    }
//}
