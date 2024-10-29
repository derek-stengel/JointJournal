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
    var entryImages: [UIImage] = [] // Changed to UIImage array
    var entryMedia: URL?
    var dateCreated: Date
}
