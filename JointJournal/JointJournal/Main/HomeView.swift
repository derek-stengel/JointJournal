//
//  ContentView.swift
//  JointJournal
//
//  Created by Derek Stengel on 10/22/24.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    @State private var selectedTab: Int = 2
    
    var body: some View {
        ZStack {
            TabView(selection: $selectedTab) {
                Text("Hello")
                    .tabItem {
                        Image(systemName: "scribble")
                        Text("Item 1")
                    }
                    .tag(0)
                
                Text("Hello")
                    .tabItem {
                        Image(systemName: "scribble")
                        Text("Item 2")
                    }
                    .tag(1)
                
                HomeDisplayView()
                    .tabItem {
                        Image(systemName: "house")
                        Text("Home")
                    }
                    .tag(2)
                
                Text("Hello")
                    .tabItem {
                        Image(systemName: "scribble")
                        Text("Item 3")
                    }
                    .tag(3)
                
                Text("Hello")
                    .tabItem {
                        Image(systemName: "scribble")
                        Text("Item 4")
                    }
                    .tag(4)
            }
        }
    }
}

#Preview {
    HomeView()
}
