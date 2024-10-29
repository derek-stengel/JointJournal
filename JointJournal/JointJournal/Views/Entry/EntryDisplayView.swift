//
//  EntryDisplayView.swift
//  JointJournal
//
//  Created by Derek Stengel on 10/22/24.
//

import SwiftUI
import Foundation

struct EntryDisplayView: View {
    var entry: Entry
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 20) {
                Text(entry.entryTitle)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, 5)
                
                Text(entry.entryText)
                    .font(.body)
                    .padding(.bottom, 10)
                
                // Display multiple images, centered
                if !entry.entryImages.isEmpty {
                    HStack {
                        Spacer() // Center images within the VStack
                        ScrollView(.horizontal) {
                            HStack {
                                ForEach(entry.entryImages, id: \.self) { uiImage in
                                    Image(uiImage: uiImage)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 200, height: 200)
                                        .cornerRadius(10)
                                        .padding(.trailing, 8)
                                }
                            }
                        }
                        Spacer()
                    }
                    .padding(.bottom, 10)
                }
                
                if let mediaURL = entry.entryMedia {
                    Link(destination: mediaURL) {
                        HStack {
                            Image(systemName: "link.circle.fill")
                                .foregroundColor(.blue)
                            Text("View Attached Media")
                                .underline()
                        }
                        .padding(.vertical, 10)
                    }
                }
                
                if let location = entry.entryLocation {
                    HStack {
                        Image(systemName: "location.fill")
                            .foregroundColor(.blue)
                        Text(location)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .padding(.bottom, 10)
                }
                
                Spacer()
            }
            .padding()
        }
        .overlay(
            VStack {
                Spacer()
                Button(action: {
                    // function here
                }) {
                    Text("Edit Entry")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(8)
                }
                .padding(.horizontal)
                .padding(.bottom)
            }
        )
    }
}

#Preview {
    EntryDisplayView(
        entry: Entry(
            entryTitle: "Cool Event",
            entryText: "This is basic filler text for the entry.",
            entryLocation: "South Jordan, UT",
            entryImages: [UIImage(systemName: "circle")!], // Sample image
            entryMedia: URL(string: "https://www.example.com"), // Placeholder URL
            dateCreated: Date()
        )
    )
}



//import SwiftUI
//import Foundation
//
//struct EntryDisplayView: View {
//    var entry: Entry
//    
//    var body: some View {
//        ScrollView {
//            VStack(alignment: .leading, spacing: 20) {
//                
//                // Title
//                Text(entry.entryTitle)
//                    .font(.largeTitle)
//                    .fontWeight(.bold)
//                    .padding(.bottom, 5)
//                
//                // Text
//                Text(entry.entryText)
//                    .font(.body)
//                    .padding(.bottom, 10)
//                
//                // Location (optional)
//                if let location = entry.entryLocation {
//                    HStack {
//                        Image(systemName: "location.fill")
//                            .foregroundColor(.blue)
//                        Text(location)
//                            .font(.subheadline)
//                            .foregroundColor(.secondary)
//                    }
//                    .padding(.bottom, 10)
//                }
//                
//                // Image (optional)
//                if let image = entry.entryImage {
//                    image
//                        .resizable()
//                        .scaledToFit()
//                        .frame(maxHeight: 200)
//                        .cornerRadius(10)
//                        .padding(.bottom, 10)
//                }
//                
//                // Media URL (optional)
//                if let mediaURL = entry.entryMedia {
//                    Link(destination: mediaURL) {
//                        HStack {
//                            Image(systemName: "link.circle.fill")
//                                .foregroundColor(.blue)
//                            Text("View Attached Media")
//                                .font(.body)
//                                .underline()
//                                .foregroundColor(.blue)
//                        }
//                        .padding(.vertical, 10)
//                    }
//                }
//                
//                Spacer()
//            }
//            .padding()
//        }
//    }
//}
//
//#Preview {
//    // Sample Entry object for preview
//    let sampleEntry = Entry(
//        entryTitle: "Sample Entry Title",
//        entryText: "This is a sample entry text for preview purposes.",
//        entryLocation: "Sample Location",
//        entryImage: Image(systemName: "photo"),
//        entryMedia: URL(string: "https://www.example.com")
//    )
//    
//    return EntryDisplayView(entry: sampleEntry)
//}
