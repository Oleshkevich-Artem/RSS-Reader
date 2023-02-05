//
//  ViewController.swift
//  RSS-Reader
//
//  Created by Oleshkevich Artem on 3.02.23.
//

import UIKit

class FeedListViewController: UITableViewController, XMLParserDelegate {
    
    var lentaRuFeeds = Feeds()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTableView()

        loadData()
    }
}
