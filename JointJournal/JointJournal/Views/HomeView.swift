//
//  HomeView.swift
//  JointJournal
//
//  Created by Derek Stengel on 10/22/24.
//

// maybe add a view that allows the user to junk journal? the image placeholder on each cell on the list could be clicked to lead there, or have the user be able to click it once the view expands upon opening the cell

import SwiftUI

struct HomeView: View {
    @State private var selectedTab: Int = 0
    @State private var entries: [Entry] = [] // Array to hold entries

    var body: some View {
        NavigationView {
            ZStack {
                TabView(selection: $selectedTab) {
                    HomeDisplayView(entries: $entries)
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
                    if selectedTab == 0 {
                        NavigationLink(destination: NewEntryView(entries: $entries)) {
                            Image(systemName: "plus")
                        }
                    } else {
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
