//
//  EditEntryView.swift
//  JointJournal
//
//  Created by Derek Stengel on 10/24/24.
//

import SwiftUI
import Foundation

struct EditEntryView: View {
    var entry: Entry
    
    var body: some View {
        VStack {
            Text("Edit Entry View")
                .font(.largeTitle)
                .padding()
            
            Text("Title: \(entry.entryTitle)")
                .font(.headline)
                .padding()
            
            Text("Text: \(entry.entryText)")
                .font(.body)
                .padding()
            
            // Add any other entry properties to display or edit here
            
            Spacer()
        }
        .navigationTitle("Edit Entry")
    }
    
}

#Preview {
    // Sample Entry object for preview
    let sampleEntry = Entry(
        entryTitle: "Sample Entry Title",
        entryText: "This is a sample entry text for preview purposes.",
        entryLocation: "Sample Location",
        entryImage: Image(systemName: "photo"),
        entryMedia: URL(string: "https://www.example.com")
    )
    
    return EditEntryView(entry: sampleEntry)
}
