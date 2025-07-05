//
//  WebViewController.swift
//  GithubUsers
//
//  Created by Vikas Kumar on 02/07/25.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    // MARK: - Private UI Properties
    private var webView: WKWebView!
    
    /// A `URL` required to load inside `Webview`
    private let url: URL
    
    // MARK: - Init Method
    /// init method
    /// - Parameter url: A `URL` required to load inside `Webview`
    init(with url: URL) {
        self.url = url
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Controller LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppColor.background
        title = url.absoluteString
        
        setupNavigationBar(showBack: true, canReload: true)
        setupWebView()
    }
    
    // MARK: - Setup UI Methods
    private func setupWebView() {
        webView = WKWebView(frame: view.bounds)
        webView.backgroundColor = AppColor.background
        webView.navigationDelegate = self
        view.addSubview(webView)
        
        loadWebView()
    }
    
    private func loadWebView() {
        showLoader()
        let request = URLRequest(url: url)
        webView.load(request)
    }
    
    // MARK: - Reload Action Method
    override func reloadTapped() {
        loadWebView()
    }
}

// MARK: - WebView Navigation Delegate Methods
extension WebViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        hideLoader()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: any Error) {
        hideLoader()
        showErrorLabel(with: "Found error while loading repository - \(error.localizedDescription)")
    }
}
