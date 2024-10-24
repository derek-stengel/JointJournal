//
//  HomeDisplayView.swift
//  JointJournal
//
//  Created by Derek Stengel on 10/22/24.
//

import SwiftUI

struct HomeDisplayView: View {
    @Binding var entries: [Entry] // Array to store entries
    
    var body: some View {
        VStack {
            if entries.isEmpty {
                Text("Create your first entry using the plus button")
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding()
            } else {
                List(entries) { entry in
                    VStack(alignment: .leading) {
                        // If the title is empty, display the current date
                        Text(entry.entryTitle.isEmpty ? "No Title" : entry.entryTitle)
                            .font(.headline)
                        
                        // Entry Text
                        if !entry.entryText.isEmpty {
                            Text(entry.entryText)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        
                        // Optional Entry Location
                        if let location = entry.entryLocation {
                            Text("Location: \(location)")
                                .font(.footnote)
                                .foregroundColor(.blue)
                        }
                        
                        // Optional Image
                        if let image = entry.entryImage {
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(height: 150)
                                .cornerRadius(8)
                                .padding(.top, 5)
                        }
                        
                        // Optional Media
                        if let mediaURL = entry.entryMedia {
                            Text("Media available: \(mediaURL.absoluteString)")
                                .font(.footnote)
                                .foregroundColor(.green)
                        }
                    }
                    .padding(.vertical, 5)
                }
            }
        }
        .navigationTitle("Your Entries")
        .navigationBarTitleDisplayMode(.inline)
        .padding()
    }
}

#Preview {
    HomeDisplayView(entries: .constant([Entry(entryTitle: "Cool Night Out!", entryText: "Nothing blah blah blah", entryLocation: "South Jordan", entryImage: Image(._9_F_536_DAF_6_F_96_4_EFF_A_2_F_3_D_699_A_74_D_0_B_65), entryMedia: nil)]))
}
