//
//  LocationPickerView.swift
//  JointJournal
//
//  Created by Derek Stengel on 10/23/24.
//

import SwiftUI

struct LocationPickerView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var entryLocation: String
    
    var body: some View {
        VStack {
            Text("Enter Location")
                .font(.headline)
                .padding(.bottom, 10)
            
            TextField("Location", text: $entryLocation)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button("Save") {
                dismiss()
            }
            .padding()
            .foregroundColor(.white)
            .background(Color.blue)
            .cornerRadius(8)
        }
        .padding()
    }
}

struct LocationPickerView_Previews: PreviewProvider {
    static var previews: some View {
        LocationPickerView(entryLocation: .constant("Sample Location"))
    }
}
