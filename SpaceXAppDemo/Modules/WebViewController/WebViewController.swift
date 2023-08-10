//
//  WebViewController.swift
//  SpaceXAppDemo
//
//  Created by Javier Vazquez on 09/08/23.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

    let webView = WKWebView()
    var url: URL
    
    init(url: URL) {
        self.url = url
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(webView)
        webView.load(URLRequest(url: self.url))
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webView.frame = view.bounds
    }

}
