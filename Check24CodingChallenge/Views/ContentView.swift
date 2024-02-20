//
//  ContentView.swift
//  Check24CodingChallenge
//
//  Created by Luka Lešić on 20.02.2024..
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ProductListViewModel()
    
    var body: some View {
        TabView {
            ProductListMainView()
                .environmentObject(viewModel)
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
