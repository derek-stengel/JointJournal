//
//  NewEntryView.swift
//  JointJournal
//
//  Created by Derek Stengel on 10/22/24.
//

import SwiftUI

struct NewEntryView: View {
    @Environment(\.dismiss) var dismiss
    @State private var isEditorFocused: Bool = false
    
    @Binding var entries: [Entry]
    @State private var entryTitle: String = ""
    @State private var entryText: String = ""
    @State private var entryLocation: String = ""
    @State private var entryImages: [UIImage] = []
    @State private var entryMedia: URL? = nil
    
    @State private var showImagePicker: Bool = false
    @State private var showVideoPicker: Bool = false
    @State private var showAudioPicker: Bool = false
    @State private var showLocationPicker: Bool = false
    
    @State private var showImageAlert: Bool = false
    @State private var showVideoAlert: Bool = false
    @State private var imageAlertMessage: String = ""
    @State private var videoAlertMessage: String = ""
    
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
                
                Spacer()
            }
            
            .padding()
            .navigationBarTitle(Text(Date(), style: .date), displayMode: .inline)
            .navigationTitle(Text(Date(), style: .date))
            
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
                
                // header buttons
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        let newEntry = Entry(
                            entryTitle: entryTitle,
                            entryText: entryText,
                            entryLocation: entryLocation.isEmpty ? "---" : entryLocation,
                            entryImages: entryImages,
                            entryMedia: entryMedia,
                            dateCreated: Date()
                        )
                        entries.append(newEntry)
                        dismiss()
                    }
                    .foregroundColor(.blue)
                }
            }
            
            // keyboard buttons
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    HStack(spacing: 0) {
                        Button(action: { showImagePicker = true }) {
                            Image(systemName: "photo.fill")
                                .frame(maxWidth: .infinity)
                                .foregroundColor(.black)
                        }
                        .sheet(isPresented: $showImagePicker) {
                            ImagePickerView(selectedImages: $entryImages, isPresented: $showImagePicker, imageAlertMessage: $imageAlertMessage, showImageAlert: $showImageAlert)
                        }
                        .alert(isPresented: $showImageAlert) {
                            Alert(title: Text(""), message: Text(imageAlertMessage), dismissButton: .default(Text("OK")))
                        }
                        
                        Spacer()
                        
                        Button(action: { showVideoPicker = true }) {
                            Image(systemName: "video.fill")
                                .frame(maxWidth: .infinity)
                                .foregroundColor(.black)
                        }
                        .sheet(isPresented: $showVideoPicker) {
                            VideoPickerView(selectedVideoURL: $entryMedia, isPresented: $showVideoPicker, videoAlertMessage: $videoAlertMessage, showVideoAlert: $showVideoAlert)
                        }
                        .alert(isPresented: $showVideoAlert) {
                            Alert(title: Text("Media Alert"), message: Text(videoAlertMessage), dismissButton: .default(Text("OK")))
                        }
                        
                        Spacer()
                        
                        Button(action: { showAudioPicker = true }) {
                            Image(systemName: "mic.fill")
                                .frame(maxWidth: .infinity)
                                .foregroundColor(.black)
                        }
                        .sheet(isPresented: $showAudioPicker) {
                            AudioRecorderView()
                        }
                        
                        Spacer()
                        
                        Button(action: { showLocationPicker = true }) {
                            Image(systemName: "location.fill")
                                .frame(maxWidth: .infinity)
                                .foregroundColor(.black)
                        }
                        .sheet(isPresented: $showLocationPicker) {
                            LocationPickerView(entryLocation: $entryLocation)
                        }
                        
                    }
                    .frame(maxWidth: .infinity, maxHeight: 50)
                    .background(Color.clear)
                }
            }
            //            .sheet(isPresented: $showImagePicker) {
            //                ImagePickerView(selectedImage: $entryImage, isPresented: $showImagePicker, imageAlertMessage: $imageAlertMessage, showImageAlert: $showImageAlert)
            //            }
            //            .sheet(isPresented: $showVideoPicker) {
            //                VideoPickerView(selectedVideoURL: $entryMedia, isPresented: $showVideoPicker, videoAlertMessage: $videoAlertMessage, showVideoAlert: $showVideoAlert)
            //            }
            //            .sheet(isPresented: $showAudioPicker) {
            //                AudioRecorderView()
            //            }
            //            .sheet(isPresented: $showLocationPicker) {
            //                LocationPickerView()
            //            }
            //            .alert(isPresented: $showImageAlert) {
            //                Alert(title: Text("Image Alert"), message: Text(imageAlertMessage), dismissButton: .default(Text("OK")))
            //            }
        }
        .navigationBarBackButtonHidden()
        .background(Color(.systemBackground))
    }
}

#Preview {
    NewEntryView(entries: .constant([Entry(entryTitle: "Cool title", entryText: "Blah blah blah", dateCreated: Date())]))
}



//import SwiftUI
//
//struct NewEntryView: View {
//    @Environment(\.dismiss) var dismiss
//    @State private var isEditorFocused: Bool = false
//    @Binding var entries: [Entry]
//
//    @State private var entryTitle: String = ""
//    @State private var entryText: String = ""
//    @State private var entryLocation: String = ""
//    @State private var entryImage: Image? = nil
//    @State private var entryMedia: URL? = nil
//
//    @State private var showImagePicker: Bool = false
//    @State private var showVideoPicker: Bool = false
//    @State private var showAudioPicker: Bool = false
//    @State private var showLocationPicker: Bool = false
//
//    @State private var showImageAlert: Bool = false
//    @State private var imageAlertMessage: String = ""
//    @State private var showVideoAlert: Bool = false
//    @State private var videoAlertMessage: String = ""
//
//    var body: some View {
//        NavigationView {
//            VStack(alignment: .leading) {
//                TextField("Title", text: $entryTitle)
//                    .font(.title3)
//                    .bold()
//                    .padding(.vertical, 10)
//                    .padding(.horizontal)
//                    .background(Color(.systemGray6))
//                    .cornerRadius(8)
//                    .padding(.bottom, 8)
//
//                ZStack(alignment: .topLeading) {
//                    TextEditor(text: $entryText)
//                        .padding(4)
//                        .background(Color(.systemGray6))
//                        .cornerRadius(8)
//                        .frame(minHeight: 200)
//                        .onTapGesture {
//                            isEditorFocused = true
//                        }
//                        .onChange(of: entryText) { _ in
//                            if entryText.isEmpty {
//                                isEditorFocused = false
//                            }
//                        }
//                }
//                .padding(.bottom)
//
//                Spacer()
//
//            }
//
//            .padding()
//            .navigationBarTitle(Text(Date(), style: .date), displayMode: .inline)
//            .navigationTitle(Text(Date(), style: .date))
//
//            .toolbar {
//                ToolbarItem(placement: .navigationBarLeading) {
//                    Button(action: {
//                        dismiss()
//                    }) {
//                        HStack {
//                            Image(systemName: "chevron.left")
//                                .font(.system(size: 14))
//                            Text("Back")
//                        }
//                        .foregroundColor(.blue)
//                    }
//                }
//
//                // header buttons
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    Button("Save") {
//                        let newEntry = Entry(
//                            entryTitle: entryTitle,
//                            entryText: entryText,
//                            entryLocation: entryLocation.isEmpty ? "No location Given" : entryLocation,
//                            entryImage: entryImage,
//                            entryMedia: entryMedia
//                        )
//                        entries.append(newEntry)
//                        dismiss()
//                    }
//                    .foregroundColor(.blue)
//                }
//            }
//
//            // keyboard buttons
//            .toolbar {
//                ToolbarItemGroup(placement: .keyboard) {
//                    HStack(spacing: 0) {
//                        Button(action: { showImagePicker = true }) {
//                            Image(systemName: "photo.fill")
//                                .frame(maxWidth: .infinity)
//                                .foregroundColor(.black)
//                        }
//                        .sheet(isPresented: $showImagePicker) {
//                            ImagePickerView(selectedImage: $entryImage, isPresented: $showImagePicker, imageAlertMessage: $imageAlertMessage, showImageAlert: $showImageAlert)
//                        }
//                        .alert(isPresented: $showImageAlert) {
//                            Alert(title: Text(""), message: Text(imageAlertMessage), dismissButton: .default(Text("OK")))
//                        }
//
//                        Spacer()
//
//                        Button(action: { showVideoPicker = true }) {
//                            Image(systemName: "video.fill")
//                                .frame(maxWidth: .infinity)
//                                .foregroundColor(.black)
//                        }
//                        .sheet(isPresented: $showVideoPicker) {
//                            VideoPickerView(selectedVideoURL: $entryMedia, isPresented: $showVideoPicker, videoAlertMessage: $videoAlertMessage, showVideoAlert: $showVideoAlert)
//                        }
//                        .alert(isPresented: $showVideoAlert) {
//                            Alert(title: Text("Media Alert"), message: Text(videoAlertMessage), dismissButton: .default(Text("OK")))
//                        }
//
//                        Spacer()
//
//                        Button(action: { showAudioPicker = true }) {
//                            Image(systemName: "mic.fill")
//                                .frame(maxWidth: .infinity)
//                                .foregroundColor(.black)
//                        }
//                        .sheet(isPresented: $showAudioPicker) {
//                            AudioRecorderView()
//                        }
//
//                        Spacer()
//
//                        Button(action: { showLocationPicker = true }) {
//                            Image(systemName: "location.fill")
//                                .frame(maxWidth: .infinity)
//                                .foregroundColor(.black)
//                        }
//                        .sheet(isPresented: $showLocationPicker) {
//                            LocationPickerView()
//                        }
//
//                    }
//                    .frame(maxWidth: .infinity, maxHeight: 50)
//                    .background(Color.clear)
//                }
//            }
////            .sheet(isPresented: $showImagePicker) {
////                ImagePickerView(selectedImage: $entryImage, isPresented: $showImagePicker, imageAlertMessage: $imageAlertMessage, showImageAlert: $showImageAlert)
////            }
////            .sheet(isPresented: $showVideoPicker) {
////                VideoPickerView(selectedVideoURL: $entryMedia, isPresented: $showVideoPicker, videoAlertMessage: $videoAlertMessage, showVideoAlert: $showVideoAlert)
////            }
////            .sheet(isPresented: $showAudioPicker) {
////                AudioRecorderView()
////            }
////            .sheet(isPresented: $showLocationPicker) {
////                LocationPickerView()
////            }
////            .alert(isPresented: $showImageAlert) {
////                Alert(title: Text("Image Alert"), message: Text(imageAlertMessage), dismissButton: .default(Text("OK")))
////            }
//        }
//        .navigationBarBackButtonHidden()
//        .background(Color(.systemBackground))
//    }
//}
//
//#Preview {
//    NewEntryView(entries: .constant([Entry(entryTitle: "Cool title", entryText: "Blah blah blah")]))
//}
