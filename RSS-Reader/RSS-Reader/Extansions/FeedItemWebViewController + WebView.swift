//
//  FeedItemWebViewController + WebView.swift
//  RSS-Reader
//
//  Created by Oleshkevich Artem on 5.02.23.
//

import Foundation
import UIKit
import WebKit

extension FeedItemWebViewController {
    
    func setUpWebView() {
        loadingObservation = webView.observe(\.isLoading, options: [.new, .old]) { [weak self] (_, change) in
            guard let strongSelf = self else { return }
            
            if change.newValue! && !change.oldValue! {
                strongSelf.view.addSubview(strongSelf.loadingIndicator)
                strongSelf.loadingIndicator.startAnimating()
                NSLayoutConstraint.activate([strongSelf.loadingIndicator.centerXAnchor.constraint(equalTo: strongSelf.view.centerXAnchor),
                                             strongSelf.loadingIndicator.centerYAnchor.constraint(equalTo: strongSelf.view.centerYAnchor)])
                strongSelf.view.bringSubviewToFront(strongSelf.loadingIndicator)
            }
            
            else if !change.newValue! && change.oldValue! {
                strongSelf.loadingIndicator.stopAnimating()
                strongSelf.loadingIndicator.removeFromSuperview()
            }
        }
        
        selectedFeedURL =  selectedFeedURL?.replacingOccurrences(of: " ", with:"")
        selectedFeedURL =  selectedFeedURL?.replacingOccurrences(of: "\n", with:"")
        webView.backgroundColor = .black
        webView.load(URLRequest(url: URL(string: selectedFeedURL! as String)!))
    }
    
    func spinnerSetUp() -> UIActivityIndicatorView {
        let spinner = UIActivityIndicatorView()
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.color = .lightGray
        spinner.transform = CGAffineTransform(scaleX: 2, y: 2)
        return spinner
    }
}
