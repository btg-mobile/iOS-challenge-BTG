//
//  WebPageVC.swift
//  RicardoMartinsFeatureDemo
//
//  Created by Ricardo Martins on 12/10/19.
//  Copyright © 2019 https://ricardo.dev - Ricardo Martins. All rights reserved.
//

import WebKit

enum WebPageEnum{
    case ricardoMartins
    
    var url:URL{
        switch self {
        case .ricardoMartins:
            return URL(string: "https://www.ricardo.dev")!
        }
    }
    
    var title:String{
        switch self {
        case .ricardoMartins:
            return String.Localizable.app.getValue(code: 1)
        }
    }
}

class WebPageVC: UIViewController{
    var page:WebPageEnum = .ricardoMartins
    
    let webView = WKWebView(frame: .zero, configuration: WKWebViewConfiguration())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        loadURL()
    }
    
    convenience init(page:WebPageEnum){
        self.init()
        self.page = page
    }
    
    fileprivate func setupView(){
        view.backgroundColor = .white
        view.addSubview(webView)
        webView.navigationDelegate = self
        webView.uiDelegate = self
        webView.anchorFillSuperView()
    }
    
    fileprivate func loadURL(){
        startAnimating()
        let url = page.url
        let request = URLRequest(url: url)
        webView.load(request)
    }
}

extension WebPageVC: WKUIDelegate, WKNavigationDelegate{
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        stopAnimating()
    }
}

