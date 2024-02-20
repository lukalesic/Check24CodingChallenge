//
//  CustomWKWebView.swift
//  Check24CodingChallenge
//
//  Created by Luka Lešić on 20.02.2024..
//

import Foundation
import SwiftUI
import WebKit
import UIKit

class CustomWkWebView: UIViewController, WKNavigationDelegate {
    
    var webView: WKWebView = {
        let webView = WKWebView(frame: .zero)
        return webView
    }()
    
    private let url: URL
    
    init(url: URL) {
        self.url = url
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        view.addSubview(webView)
        webView.load(URLRequest(url: url))
        configureButtons()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webView.frame = view.bounds
    }
    
    private func configureButtons() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Done",
                                                           style: .done,
                                                           target: nil,
                                                           action: #selector(didTapDone))
    }
    
    @objc private func didTapDone() {
        dismiss(animated: true)
    }
}

struct WebViewRepresentable: UIViewControllerRepresentable {
    
    let url: URL
    
    func makeUIViewController(context: Context) -> CustomWkWebView {
        let view = CustomWkWebView(url: url)
        return view
    }
    
    func updateUIViewController(_ webView: CustomWkWebView, context: Context) {
    }
}
