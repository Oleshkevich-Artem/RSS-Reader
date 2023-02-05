//
//  NetworkParseManager.swift
//  RSS-Reader
//
//  Created by Oleshkevich Artem on 3.02.23.
//

import Foundation

import Foundation

class NetworkManager: NSObject, XMLParserDelegate {
    
    var parser = XMLParser()
    var networkResponce = NetworkResponce()
    
    func initWithURL(_ url :URL) -> AnyObject {
        startParse(url)
        return self
    }
    
    func startParse(_ url: URL) {
        networkResponce.feeds = []
        parser = XMLParser(contentsOf: url)!
        parser.delegate = self
        parser.shouldProcessNamespaces = false
        parser.shouldReportNamespacePrefixes = false
        parser.shouldResolveExternalEntities = false
        parser.parse()
    }
    
    func allFeeds() -> NSMutableArray {
        return networkResponce.feeds
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        networkResponce.item = elementName as String
        if (networkResponce.item as NSString).isEqual(to: "item") {
            networkResponce.items =  NSMutableDictionary()
            networkResponce.items = [:]
            networkResponce.feedTitle = String()
            networkResponce.feedTitle = ""
            networkResponce.feedLink = String()
            networkResponce.feedLink = ""
            networkResponce.feedDescription = String()
            networkResponce.feedDescription = ""
            networkResponce.feedDate = String()
            networkResponce.feedDate = ""
        }
        
        else if (networkResponce.item as NSString).isEqual(to: "enclosure") {
            if let urlString = attributeDict["url"] {
                networkResponce.feedsImages.append(urlString as AnyObject)
            }
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {

        if (elementName as NSString).isEqual(to: "item") {
            if networkResponce.feedTitle != "" {
                networkResponce.items.setObject(networkResponce.feedTitle, forKey: "title" as NSCopying)
            }
            if networkResponce.feedLink != "" {
                networkResponce.items.setObject(networkResponce.feedLink, forKey: "link" as NSCopying)
            }
            if description != "" {
                networkResponce.items.setObject(networkResponce.feedDescription, forKey: "description" as NSCopying)
            }
            if networkResponce.feedDate != "" {
                networkResponce.items.setObject(convertDateFormat(inputDate: networkResponce.feedDate), forKey: "pubDate" as NSCopying)
            }
            networkResponce.feeds.add(networkResponce.items)
        }
    }
    
    func convertDateFormat(inputDate: String) -> String {

        let oldDateFormatter = DateFormatter()
        oldDateFormatter.dateFormat = "E, d MMM yyyy HH:mm:ss Z"
        var oldDate: Date = Date()
        if let date = oldDateFormatter.date(from: inputDate) {
            oldDate = date
        }
         let convertDateFormatter = DateFormatter()
         convertDateFormatter.dateFormat = "dd-MM-yyyy hh:mm"

        return convertDateFormatter.string(from: oldDate)
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if networkResponce.item.isEqual("title") {
            networkResponce.feedTitle.append(string)
        } else if networkResponce.item.isEqual("link") {
            networkResponce.feedLink.append(string)
        } else if networkResponce.item.isEqual("description") {
            networkResponce.feedDescription.append(string)
        } else if networkResponce.item.isEqual("pubDate") {
            networkResponce.feedDate.append(string)
        }
    }
}

