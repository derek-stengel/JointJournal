//
//  HomeDisplayView.swift
//  JointJournal
//
//  Created by Derek Stengel on 10/22/24.
//

import Foundation
import SwiftUI

struct HomeDisplayView: View {
    @Binding var entries: [Entry]
    @Binding var showPlusButton: Bool
    
    var body: some View {
        VStack {
            if entries.isEmpty {
                Text("Create your first entry using the plus button")
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding()
            } else {
                List(entries) { entry in
                    NavigationLink(destination: EntryDisplayView(entry: entry)
                        .onAppear {
                            showPlusButton = false
                        }
                        .onDisappear {
                            showPlusButton = true
                        }) {
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(entry.entryTitle.isEmpty ? "No Title" : entry.entryTitle)
                                        .font(.headline)
                                    
                                    if !entry.entryText.isEmpty {
                                        Text(entry.entryText)
                                            .font(.subheadline)
                                            .foregroundColor(.secondary)
                                    }
                                    
                                    if let location = entry.entryLocation {
                                        Text("Location: \(location)")
                                            .font(.footnote)
                                            .foregroundColor(.blue)
                                    }
                                    
                                    if let mediaURL = entry.entryMedia {
                                        Text("Video Attached")
                                            .font(.footnote)
                                            .foregroundColor(.green)
                                    }
                                }
                                
                                Spacer()
                                
                                if let image = entry.entryImage {
                                    image
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: 80)
                                        .cornerRadius(8)
                                        .padding(.top, 5)
                                }
                            }
                            .padding(.vertical, 5)
                        }
                }
            }
        }
    }
}
