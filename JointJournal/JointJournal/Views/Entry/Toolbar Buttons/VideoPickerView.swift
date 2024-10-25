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
        
        // Using loadTransferable to load the video file as Data
        item.loadTransferable(type: Data.self) { result in
            switch result {
            case .success(let data):
                if let data = data {
                    // Create a temporary file URL to save the video data
                    let tempURL = FileManager.default.temporaryDirectory.appendingPathComponent("\(UUID().uuidString).mov")
                    
                    do {
                        try data.write(to: tempURL)
                        selectedVideoURL = tempURL
                        isPresented = false // Dismiss the sheet
                        
                        // Alert for successful import
                        videoAlertMessage = "Media successfully imported!"
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                            showVideoAlert = true
                        }
                    } catch {
                        print("Failed to save video to temporary directory: \(error.localizedDescription)")
                    }
                }
            case .failure(let error):
                print("Failed to load video: \(error.localizedDescription)")
            }
        }
    }
}
