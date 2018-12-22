//
//  ViewController.swift
//  WebBrowserApp
//
//  Created by Artem Karmaz on 12/22/18.
//  Copyright © 2018 Artem Karmaz. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIWebViewDelegate {

    let application = UIApplication.shared
    
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var goBackItem: UIBarButtonItem!
    @IBOutlet weak var goForwardItem: UIBarButtonItem!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var textField: UITextField!
    
    
    @IBAction func goButton(_ sender: UIButton) {
        let myUrl = URL(string: "https://\(textField.text?.replacingOccurrences(of: " ", with: "") ?? "https://google.com")")
        guard let unwrappedUrlRequest = myUrl else { return }
        let request = URLRequest(url: unwrappedUrlRequest)
        webView.loadRequest(request)
    }
    
    
    @IBAction func goBackButton(_ sender: UIBarButtonItem) {
        if webView.canGoBack {
            webView.goBack()
        }
    }
    
    @IBAction func goForwardButton(_ sender: UIBarButtonItem) {
        if webView.canGoForward {
            webView.goForward()
        }
    }
    
    @IBAction func refreshButton(_ sender: UIBarButtonItem) {
        webView.reload()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.delegate = self
        activityIndicator.isHidden = true
    }

    func workIndicator(isAnimated: Bool, indicator: UIActivityIndicatorView) {
        application.isNetworkActivityIndicatorVisible = isAnimated
        if isAnimated {
            activityIndicator.startAnimating()
            activityIndicator.isHidden = false
        } else {
            activityIndicator.startAnimating()
            activityIndicator.isHidden = true
        }
    }

    
     func webViewDidStartLoad(_ webView: UIWebView) {
        workIndicator(isAnimated: true, indicator: activityIndicator)
        self.goBackItem.isEnabled = false
        self.goForwardItem.isEnabled = false
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        workIndicator(isAnimated: false, indicator: activityIndicator)
        if webView.canGoBack {
            self.goBackItem.isEnabled = true
        } else if webView.canGoForward {
            self.goForwardItem.isEnabled = true
        }
    }
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebView.NavigationType) -> Bool {
        print("shouldStartLoadWith - \(request)")
        return true
    }
    
}

