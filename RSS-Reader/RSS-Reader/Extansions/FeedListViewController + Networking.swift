//
//  FeedListViewController + Networking.swift
//  RSS-Reader
//
//  Created by Oleshkevich Artem on 5.02.23.
//

import Foundation
import UIKit

extension FeedListViewController {
    @objc func refreshFeed(_ sender: Any) {
        loadData()
    }

    func loadData() {
        loadRSS(URL(string: API.lentaRuUrl)!)
    }

    func loadRSS(_ data: URL) {

        let parser : NetworkManager = NetworkManager().initWithURL(data) as! NetworkManager

        lentaRuFeeds.feedsImages = parser.networkResponce.feedsImages as [AnyObject]
        lentaRuFeeds.feeds = parser.networkResponce.feeds
        self.tableView.reloadData()
        self.refreshControl?.endRefreshing()
    }
}
