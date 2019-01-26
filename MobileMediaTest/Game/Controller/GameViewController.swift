//
//  GameViewController.swift
//  MobileMediaTest
//
//  Created by Роман Тищенко on 23/01/2019.
//  Copyright © 2019 Роман Тищенко. All rights reserved.
//

import UIKit
import WebKit

class GameViewController: UIViewController, WKUIDelegate, WKNavigationDelegate {
    
    @IBOutlet weak var webView: WKWebView!
    var totalLoad = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.uiDelegate = self
        webView.navigationDelegate = self
        UIDevice.current.setValue(UIInterfaceOrientation.landscapeRight.rawValue, forKey: "orientation")
        guard let gameUrl = ServerService.gcdWebServer.bonjourServerURL else { return }
        webView.load(URLRequest(url: gameUrl))
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        if totalLoad != 0 {
            guard let gameUrl = ServerService.gcdWebServer.bonjourServerURL else { return }
            webView.load(URLRequest(url: gameUrl))
            totalLoad -= 1
        }
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscapeRight
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        ServerService.gcdWebServer.stop()
        HTTPCookieStorage.shared.removeCookies(since: Date.distantPast)
        print("[WebCacheCleaner] All cookies deleted")
    }
    
    @IBAction func refresh(_ sender: UIBarButtonItem) {
        guard let gameUrl = ServerService.gcdWebServer.bonjourServerURL else { return }
        webView.load(URLRequest(url: gameUrl))
    }
}
