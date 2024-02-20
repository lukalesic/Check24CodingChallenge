//
//  FooterWKWebView.swift
//  Check24CodingChallenge
//
//  Created by Luka Lešić on 20.02.2024..
//

import SwiftUI

struct FooterTextView: View {
    @Binding var isPresentingWebLink: Bool
    
    var body: some View {
        Button {
            isPresentingWebLink = true
        } label: {
            Text("© 2024 Check24")
                .font(.caption)
        }
        .buttonStyle(.plain)
    }
}

struct FooterWebpageView: View {
    @Binding var isPresentingWebLink: Bool
    
    var body: some View {
        NavigationView {
            WebViewRepresentable(url: URL(string: APIEndpoint.footerLink)!)
                .navigationTitle("Demo footer link")
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button(action: {
                            self.isPresentingWebLink = false
                        }, label: {
                            Text("Done")
                        })
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
                .edgesIgnoringSafeArea(.bottom)
        }
    }
}
