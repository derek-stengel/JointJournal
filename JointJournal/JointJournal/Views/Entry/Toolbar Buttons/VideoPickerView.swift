//
//  VideoPickerView.swift
//  JointJournal
//
//  Created by Derek Stengel on 10/22/24.
//


import SwiftUI
import PhotosUI

struct VideoPickerView: View {
    @Binding var selectedVideoURL: URL?
    @Binding var isPresented: Bool
    @Binding var videoAlertMessage: String
    @Binding var showVideoAlert: Bool
    
    @State private var selectedItem: PhotosPickerItem? = nil
    
    var body: some View {
        PhotosPicker(selection: $selectedItem, matching: .videos) {
            Text("Select Video")
                .foregroundColor(.blue)
        }
        .onChange(of: selectedItem) { newItem in
            loadVideo(from: newItem)
        }
    }
    
    private func loadVideo(from item: PhotosPickerItem?) {
        guard let item = item else { return }
        
        // Using loadTransferable to load the video file URL
        item.loadTransferable(type: URL.self) { result in
            switch result {
            case .success(let url):
                if let url = url {
                    selectedVideoURL = url
                    isPresented = false // Dismiss the sheet
                }
            case .failure(let error):
                print("Failed to load video: \(error.localizedDescription)")
            }
            videoAlertMessage = "Media successfully imported!"
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                showVideoAlert = true
            }
            
        }
    }
}
