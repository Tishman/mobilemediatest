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
    @IBOutlet weak var refreshButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.uiDelegate = self
        webView.navigationDelegate = self
        guard let gameUrl = ServerService.gcdWebServer.bonjourServerURL else { return }
        webView.load(URLRequest(url: gameUrl))
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        switch UIDevice.current.orientation {
        case .landscapeLeft:
            refresh(refreshButton)
        case .landscapeRight:
            refresh(refreshButton)
        case .portrait:
            refresh(refreshButton)
        default:
            break
        }
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
