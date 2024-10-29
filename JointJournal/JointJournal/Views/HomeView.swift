//
//  HomeView.swift
//  JointJournal
//
//  Created by Derek Stengel on 10/22/24.
//

//                                                          MARK: 1
// Create a view called EditEntryView that allows the user to make changes to an entry, and have those changes update in real time
// create the calendar view, allowing for users to change the color of the squares on the calendar. Also, have a nav button that allows the user to configure the colors to their liking (happy could be green, or maybe blue), and bind that color so if they change it in the settings view, it updates the main view upon closing.

//                                                          MARK: 2
// maybe add a view that allows the user to junk journal? the image placeholder on each cell on the list could be clicked to lead there, or have the user be able to click it once the view expands upon opening the cell

//                                                          MARK: 3
// Change the way EntryDisplayView looks, make it cleaner
// have an option to set a time to send a reminder to the user "TIME TO JOURNAL" or something like that.

import SwiftUI

struct HomeView: View {
    @State private var selectedTab: Int = 0
    @State private var entries: [Entry] = []
    @State private var showPlusButton = true
    
    var body: some View {
        NavigationView {
            ZStack {
                TabView(selection: $selectedTab) {
                    HomeDisplayView(entries: $entries, showPlusButton: $showPlusButton)
                        .tabItem {
                            Image(systemName: "house")
                            Text("Home")
                        }
                        .tag(0)
                    
                    CalendarDisplayView()
                        .tabItem {
                            Image(systemName: "calendar")
                            Text("Mood Calendar")
                        }
                        .tag(1)
                }
            }
            .navigationBarItems(trailing:
                                    Group {
                if selectedTab == 0 && showPlusButton {
                    NavigationLink(destination: NewEntryView(entries: $entries)) {
                        Image(systemName: "plus")
                    }
                } else if selectedTab == 1 {
                    Button(action: {
                        // Placeholder action
                    }) {
                        Image(systemName: "gear")
                    }
                }
            }
            )
        }
    }
}

#Preview {
    HomeView()
}
