//
//  WebViewController.swift
//  NoSchool
//
//  Created by hirano_tomoka on 2020/03/24.
//  Copyright © 2020 inuko. All rights reserved.
//

import UIKit
import RxSwift
import ReactorKit
import WebKit
import Instantiate

final class WebViewController: UIViewController {
    
    enum Context {
        case push
        case present
    }
    
    // MARK: - Outlet
    
    @IBOutlet private weak var webViewContainer: UIView!
    
    // MARK: - Property
    
    var navigationBar = UINavigationBar()
    var disposeBag = DisposeBag()
    private let webView: WKWebView = {
        let view = WKWebView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftItemsSupplementBackButton = true
        webViewContainer.addSubview(webView)
        webView.topAnchor.constraint(equalTo: webViewContainer.topAnchor).isActive = true
        webView.bottomAnchor.constraint(equalTo: webViewContainer.bottomAnchor).isActive = true
        webView.rightAnchor.constraint(equalTo: webViewContainer.rightAnchor).isActive = true
        webView.leftAnchor.constraint(equalTo: webViewContainer.leftAnchor).isActive = true
        webView.loadHTMLString(html, baseURL: nil)
    }
    
    private let html = """
<html class="translated-ltr"><head>
<title>Flappy Bird</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="viewport" content="user-scalable=no, initial-scale=1.0, minimum-scale=1, maximum-scale=1">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black">
<link rel="apple-touch-icon" href="images/icon.png">
<link rel="apple-touch-startup-image" href="images/icon.png">

<style type="text/css">
body, div, canvas{
    image-rendering: optimizeSpeed;
    -webkit-image-rendering: optimizeSpeed;
    -webkit-interpolation-mode: nearest-neighbor;
}
body{padding:0; margin:0; font-size:12px; background-color:#fff;}
body, html{height:100%;}
</style>

<script type="text/javascript" src="hilo/hilo-standalone.js"></script>
<script type="text/javascript" src="hilo/hilo-flash.js" data-auto="true"></script>
<script type="text/javascript" src="src/game.js"></script>
<script type="text/javascript" src="src/Asset.js"></script>
<script type="text/javascript" src="src/ReadyScene.js"></script>
<script type="text/javascript" src="src/OverScene.js"></script>
<script type="text/javascript" src="src/Bird.js"></script>
<script type="text/javascript" src="src/Holdbacks.js"></script>

<link type="text/css" rel="stylesheet" charset="UTF-8" href="https://translate.googleapis.com/translate_static/css/translateelement.css"></head>

<body>


<div id="goog-gt-tt" class="skiptranslate" dir="ltr"><div style="padding: 8px;"><div><div class="logo"><img src="https://www.gstatic.com/images/branding/product/1x/translate_24dp.png" width="20" height="20" alt="Google 翻訳"></div></div></div><div class="top" style="padding: 8px; float: left; width: 100%;"><h1 class="title gray">原文</h1></div><div class="middle" style="padding: 8px;"><div class="original-text"></div></div><div class="bottom" style="padding: 8px;"><div class="activity-links"><span class="activity-link">翻訳を改善する</span><span class="activity-link"></span></div><div class="started-activity-container"><hr style="color: #CCC; background-color: #CCC; height: 1px; border: none;"><div class="activity-root"></div></div></div><div class="status-message" style="display: none;"></div></div><canvas width="900" height="1500" style="width: 450px; height: 750px;"></canvas><div class="goog-te-spinner-pos"><div class="goog-te-spinner-animation"><svg xmlns="http://www.w3.org/2000/svg" class="goog-te-spinner" width="96px" height="96px" viewBox="0 0 66 66"><circle class="goog-te-spinner-path" fill="none" stroke-width="6" stroke-linecap="round" cx="33" cy="33" r="30"></circle></svg></div></div></body></html>
"""
}
