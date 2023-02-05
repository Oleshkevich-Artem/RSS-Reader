//
//  FeedListViewController + Segue.swift
//  RSS-Reader
//
//  Created by Oleshkevich Artem on 5.02.23.
//

import Foundation
import UIKit

extension FeedListViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "openPage" {
            let indexPath: IndexPath = self.tableView.indexPathForSelectedRow!
            let selectedURL: String = (lentaRuFeeds.feeds[indexPath.row] as AnyObject).object(forKey: "link") as! String
            
            let feedItemWebViewController: FeedItemWebViewController = segue.destination as! FeedItemWebViewController
            feedItemWebViewController.selectedFeedURL = selectedURL as String
        }
    }
}
