//
//  HomeDisplayView.swift
//  JointJournal
//
//  Created by Derek Stengel on 10/22/24.
//

import SwiftUI

struct HomeDisplayView: View {
    @Binding var entries: [Entry]
    @Binding var showPlusButton: Bool
    
    var body: some View {
        ZStack {
            Color(.secondarySystemBackground)
                .ignoresSafeArea()
            VStack {
                
//                Text("Entries")
//                    .font(.largeTitle)
//                    .bold()
//                    .padding(.bottom, 10)
                
                
                if entries.isEmpty {
                    Text("Create your first entry using the plus button")
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .padding()
                } else {
                    
                    Text("Entries")
                        .font(.largeTitle)
                        .bold()
                        .padding(.bottom, 10)
                    // Group entries by date
                    let groupedEntries = Dictionary(grouping: entries) { entry in
                        // Assuming 'entry.dateCreated' is of type Date
                        Calendar.current.startOfDay(for: entry.dateCreated)
                    }
                    
                    List {
                        ForEach(groupedEntries.keys.sorted(by: >), id: \.self) { date in
                            Section(header: Text(date, style: .date).font(.headline)) {
                                ForEach(groupedEntries[date]!, id: \.id) { entry in
                                    NavigationLink(destination: EntryDisplayView(entry: entry)
                                        .onAppear {
                                            showPlusButton = false
                                        }
                                        .onDisappear {
                                            showPlusButton = true
                                        }) {
                                            HStack {
                                                VStack(alignment: .leading, spacing: 6) {
                                                    Text(entry.entryTitle.isEmpty ? "No Title" : entry.entryTitle)
                                                        .font(.headline)
                                                    
                                                    if !entry.entryText.isEmpty {
                                                        Text(entry.entryText.prefix(30) + (entry.entryText.count > 30 ? "..." : ""))
                                                            .font(.subheadline)
                                                            .foregroundColor(.secondary)
                                                    }
                                                    
                                                    if let location = entry.entryLocation {
                                                        HStack(spacing: 7) { // Reduced spacing between icon and text
                                                            Image(systemName: "location.fill")
                                                                .resizable()
                                                                .scaledToFit()
                                                                .frame(width: 14, height: 14) // Adjust size of icon
                                                                .foregroundColor(.blue) // Change color of icon if needed
                                                            
                                                            Text(location)
                                                                .font(.footnote)
                                                                .foregroundColor(.blue)
                                                        }
                                                        .padding(.vertical, 0) // Reduce vertical padding around the HStack
                                                    }
                                                    
                                                    if let mediaURL = entry.entryMedia {
                                                        Text("Video Attached")
                                                            .font(.footnote)
                                                            .foregroundColor(.green)
                                                    }
                                                }
                                                
                                                Spacer().frame(width: 45)
                                                
                                                // Handle multiple images
                                                if !entry.entryImages.isEmpty {
                                                    // Use a horizontal ScrollView for multiple images
                                                    ScrollView(.horizontal, showsIndicators: false) {
                                                        HStack(spacing: 8) {
                                                            ForEach(entry.entryImages, id: \.self) { uiImage in
                                                                Image(uiImage: uiImage) // Assuming entry.entryImages is of type [UIImage]
                                                                    .resizable()
                                                                    .scaledToFit()
                                                                    .frame(height: 80)
                                                                    .cornerRadius(8)
                                                            }
                                                        }
                                                    }
                                                    .frame(height: 80) // Set frame height to match the image height
                                                }
                                            }
                                            .padding(.vertical, 5)
                                        }
                                }
                            }
                        }
                    }
//                    .listStyle(PlainListStyle())
                    .listStyle(SidebarListStyle())
                    .background(Color(.secondarySystemBackground))
                }
            }
//            .padding()
        }
    }
}

#Preview {
    HomeDisplayView(entries: .constant([
        // Example entries with dates
        Entry(
            entryTitle: "Trip to the Beach",
            entryText: "Had a wonderful time!",
            entryLocation: "California",
            entryImages: [
                UIImage(systemName: "photo")!,
                UIImage(systemName: "photo")!,
                UIImage(systemName: "photo")!
            ],
            entryMedia: nil,
            dateCreated: Date() // Assuming you have a dateCreated property
        ),
        Entry(
            entryTitle: "Dinner at the New Restaurant",
            entryText: "The food was amazing!",
            entryLocation: nil,
            entryImages: [
                UIImage(systemName: "photo")!
            ],
            entryMedia: nil,
            dateCreated: Calendar.current.date(byAdding: .day, value: -1, to: Date())! // Example date
        ),
        Entry(
            entryTitle: "Weekend Getaway",
            entryText: "Explored the mountains all the way in the middle of nowhere.",
            entryLocation: "Colorado",
            entryImages: [
                UIImage(systemName: "photo")!,
                UIImage(systemName: "photo")!,
                UIImage(systemName: "photo")!
            ],
            entryMedia: URL(string: "https://example.com/video"),
            dateCreated: Calendar.current.date(byAdding: .day, value: -2, to: Date())! // Example date
        ),
        Entry(
            entryTitle: "Dinner at the New Restaurant",
            entryText: "The food was amazing!",
            entryLocation: nil,
            entryImages: [
                UIImage(systemName: "photo")!
            ],
            entryMedia: nil,
            dateCreated: Calendar.current.date(byAdding: .day, value: -3, to: Date())! // Example date
        ),
        Entry(
            entryTitle: "Dinner at the New Restaurant",
            entryText: "The food was amazing!",
            entryLocation: nil,
            entryImages: [
                UIImage(systemName: "photo")!
            ],
            entryMedia: nil,
            dateCreated: Calendar.current.date(byAdding: .day, value: -4, to: Date())! // Example date
        )
    ]), showPlusButton: .constant(true))
}


//import SwiftUI
//
//struct HomeDisplayView: View {
//    @Binding var entries: [Entry]
//    @Binding var showPlusButton: Bool
//
//    var body: some View {
//        VStack {
//            if entries.isEmpty {
//                Text("Create your first entry using the plus button")
//                    .foregroundColor(.gray)
//                    .multilineTextAlignment(.center)
//                    .padding()
//            } else {
//                List(entries) { entry in
//                    NavigationLink(destination: EntryDisplayView(entry: entry)
//                        .onAppear {
//                            showPlusButton = false
//                        }
//                        .onDisappear {
//                            showPlusButton = true
//                        }) {
//                        HStack {
//                            VStack(alignment: .leading, spacing: 6) {
//                                Text(entry.entryTitle.isEmpty ? "No Title" : entry.entryTitle)
//                                    .font(.headline)
//
//                                if !entry.entryText.isEmpty {
//                                    Text(entry.entryText.prefix(30) + (entry.entryText.count > 30 ? "..." : ""))
//                                        .font(.subheadline)
//                                        .foregroundColor(.secondary)
//                                }
//
//                                if let location = entry.entryLocation {
//                                    HStack(spacing: 7) { // Reduced spacing between icon and text
//                                        Image(systemName: "location.fill")
//                                            .resizable()
//                                            .scaledToFit()
//                                            .frame(width: 14, height: 14) // Adjust size of icon
//                                            .foregroundColor(.blue) // Change color of icon if needed
//
//                                        Text(location)
//                                            .font(.footnote)
//                                            .foregroundColor(.blue)
//                                    }
//                                    .padding(.vertical, 0) // Reduce vertical padding around the HStack
//                                }
//
//                                if let mediaURL = entry.entryMedia {
//                                    Text("Video Attached")
//                                        .font(.footnote)
//                                        .foregroundColor(.green)
//                                }
//                            }
//
//                            Spacer().frame(width: 45)
//
//
//                            // Handle multiple images
//                            if !entry.entryImages.isEmpty {
//                                // Use a horizontal ScrollView for multiple images
//                                ScrollView(.horizontal, showsIndicators: false) {
//                                    HStack(spacing: 8) {
//                                        ForEach(entry.entryImages, id: \.self) { uiImage in
//                                            Image(uiImage: uiImage) // Assuming entry.entryImages is of type [UIImage]
//                                                .resizable()
//                                                .scaledToFit()
//                                                .frame(height: 80)
//                                                .cornerRadius(8)
//                                        }
//                                    }
//                                }
//                                .frame(height: 80) // Set frame height to match the image height
//                            }
//                        }
//                        .padding(.vertical, 5)
//                    }
//                }
//            }
//        }
//    }
//}
//
//#Preview {
//    HomeDisplayView(entries: .constant([
//        // Entry with multiple images
//        Entry(
//            entryTitle: "Trip to the Beach",
//            entryText: "Had a wonderful time!",
//            entryLocation: "California",
//            entryImages: [
//                UIImage(systemName: "photo")!,
//                UIImage(systemName: "photo")!,
//                UIImage(systemName: "photo")!
//            ],
//            entryMedia: nil
//        ),
//        // Entry with a single image
//        Entry(
//            entryTitle: "Dinner at the New Restaurant",
//            entryText: "The food was amazing!",
//            entryLocation: nil,
//            entryImages: [
//                UIImage(systemName: "photo")!
//            ],
//            entryMedia: nil
//        ),
//        // Entry with multiple images and a media link
//        Entry(
//            entryTitle: "Weekend Getaway",
//            entryText: "Explored the mountains all the way in the middle of nowhere.",
//            entryLocation: "Colorado",
//            entryImages: [
//                UIImage(systemName: "photo")!,
//                UIImage(systemName: "photo")!,
//                UIImage(systemName: "photo")!
//            ],
//            entryMedia: URL(string: "https://example.com/video")
//        )
//    ]), showPlusButton: .constant(true))
//}
