//
//  ContentView.swift
//  Check24CodingChallenge
//
//  Created by Luka Lešić on 20.02.2024..
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            ProductListMainView()
                .toolbar(.hidden, for: .tabBar)
                .tabItem {
                    Label("Product List", systemImage: "list.dash")
                }
        }
    }
}

#Preview {
    ContentView()
}
