//
//  ContentView.swift
//  ApiMvvm
//
//  Created by hendra on 14/10/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            NewHotView()
                .tabItem {
                    Label("New Hot", systemImage: "arrow.2.circlepath.circle")
                }
            FastLaughsView()
                .tabItem {
                    Label("Fast Laughs", systemImage: "face.smiling.inverse")
                }
            DownloadsView()
                .tabItem {
                    Label("Downloads", systemImage: "arrow.down.circle")
                }
        }
    }
}

#Preview {
    ContentView()
}
