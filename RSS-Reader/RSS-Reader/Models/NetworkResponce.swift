//
//  NetworkResponce.swift
//  RSS-Reader
//
//  Created by Oleshkevich Artem on 5.02.23.
//

import Foundation

struct NetworkResponce {
    var feeds = NSMutableArray()
    var items = NSMutableDictionary()
    var item = String()
    var feedTitle = String()
    var feedLink = String()
    var feedsImages:  [AnyObject] = []
    var feedDescription = String()
    var feedDate = String()
}
