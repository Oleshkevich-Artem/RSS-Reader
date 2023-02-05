//
//  FeedItemViewController.swift
//  RSS-Reader
//
//  Created by Oleshkevich Artem on 3.02.23.
//

import UIKit
import WebKit

class FeedItemWebViewController: UIViewController {
    @IBOutlet var webView: WKWebView!
    
    var selectedFeedURL: String?
    
    var loadingObservation: NSKeyValueObservation?
    
    lazy var loadingIndicator: UIActivityIndicatorView = spinnerSetUp()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear( animated )
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpWebView()
    }
}
