//
//  EntryModel.swift
//  JointJournal
//
//  Created by Derek Stengel on 10/22/24.
//

import Foundation
import SwiftUI

struct Entry: Identifiable {
    var id = UUID().uuidString
    var entryTitle: String
    var entryText: String
    var entryLocation: String?
    var entryImage: Image?
    var entryMedia: URL?
    
    // If entryTitle is empty, return formatted date as default
//    var displayTitle: String {
//        if entryTitle.isEmpty {
//            let formatter = DateFormatter()
//            formatter.dateStyle = .short
//            return formatter.string(from: Date())  // Current date formatted as short style
//        }
//        return entryTitle
//    }
}

