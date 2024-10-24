import SwiftUI
import PhotosUI
import MapKit

struct NewEntryView: View {
    @Environment(\.dismiss) var dismiss
    @State private var isEditorFocused: Bool = false
    @Binding var entries: [Entry]
    
    @State private var entryTitle: String = ""
    @State private var entryText: String = ""
    @State private var entryLocation: String = ""
    @State private var entryImage: Image? = nil
    @State private var entryMedia: URL? = nil
    
    @State private var showImagePicker: Bool = false
    @State private var showVideoPicker: Bool = false
    @State private var showAudioPicker: Bool = false
    @State private var showLocationPicker: Bool = false
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                TextField("Title", text: $entryTitle)
                    .font(.title3)
                    .bold()
                    .padding(.vertical, 10)
                    .padding(.horizontal)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .padding(.bottom, 8)
                
                ZStack(alignment: .topLeading) {
                    TextEditor(text: $entryText)
                        .padding(4)
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                        .frame(minHeight: 200)
                        .onTapGesture {
                            isEditorFocused = true
                        }
                        .onChange(of: entryText) { _ in
                            if entryText.isEmpty {
                                isEditorFocused = false
                            }
                        }
                }
                .padding(.bottom)
                
                .padding()
                .foregroundColor(.black) // text color
            }
            .navigationBarTitle(Text(Date(), style: .date), displayMode: .inline)
            .padding()
            
            // Navigation Toolbar
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        dismiss()
                    }) {
                        HStack {
                            Image(systemName: "chevron.left")
                                .font(.system(size: 14))
                            Text("Back")
                        }
                        .foregroundColor(.blue)
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        // Create new entry and pass it back using the closure
                        let newEntry = Entry(
                            entryTitle: entryTitle,
                            entryText: entryText,
                            entryLocation: entryLocation.isEmpty ? "No location Given" : entryLocation,
                            entryImage: entryImage,
                            entryMedia: entryMedia
                        )
                        entries.append(newEntry)
                        dismiss()
                    }
                    .foregroundColor(.blue)
                }
            }
            
            // Keyboard Toolbar Icons
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    HStack(spacing: 0) {
                        Button(action: {
                            showImagePicker = true
                        }) {
                            Image(systemName: "photo.fill")
                                .frame(maxWidth: .infinity)
                                .foregroundColor(.black)
                        }
                        Spacer()
                        Button(action: {
                            showVideoPicker = true
                        }) {
                            Image(systemName: "video.fill")
                                .frame(maxWidth: .infinity)
                                .foregroundColor(.black)
                        }
                        Spacer()
                        Button(action: {
                            showAudioPicker = true
                        }) {
                            Image(systemName: "mic.fill")
                                .frame(maxWidth: .infinity)
                                .foregroundColor(.black)
                        }
                        Spacer()
                        Button(action: {
                            showLocationPicker = true
                        }) {
                            Image(systemName: "location.fill")
                                .frame(maxWidth: .infinity)
                                .foregroundColor(.black)
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: 50)
                    .background(Color.clear)
                }
            }
            
            .sheet(isPresented: $showImagePicker) {
                // Image picker logic
                ImagePickerView()
            }
            .sheet(isPresented: $showVideoPicker) {
                // Video picker logic
                VideoPickerView()
            }
            .sheet(isPresented: $showAudioPicker) {
                // Audio picker logic
                AudioRecorderView()
            }
            .sheet(isPresented: $showLocationPicker) {
                // Location picker logic
                LocationPickerView()
            }
        }
        .navigationBarBackButtonHidden()
        .background(Color(.systemBackground))
    }
}


#Preview {
    NewEntryView(entries: .constant([Entry(entryTitle: "Cool title", entryText: "Blah blah blah")]))
}
