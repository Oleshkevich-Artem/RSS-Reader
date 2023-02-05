//
//  FeedListViewController + TableView.swift
//  RSS-Reader
//
//  Created by Oleshkevich Artem on 5.02.23.
//

import Foundation
import UIKit

extension FeedListViewController {
    
    func setUpTableView() {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 140
        tableView.backgroundColor = .black
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.refreshControl?.addTarget(self, action: #selector(refreshFeed), for: UIControl.Event.valueChanged)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lentaRuFeeds.feeds.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let cellBGColorView = UIView()
        let cellImageLayer: CALayer?  = cell.imageView?.layer
        let url = NSURL(string: lentaRuFeeds.feedsImages[indexPath.row] as! String)
        let data = NSData(contentsOf: url! as URL)
        var image = UIImage(data: data! as Data)
        
        image = resizeImage(image: image!, toTheSize: CGSize(width: 80, height: 80))
        
        cellImageLayer!.cornerRadius = 40
        cellImageLayer!.masksToBounds = true
        cellBGColorView.backgroundColor = .clear
        
        cell.backgroundColor = .white
        
        cell.textLabel?.backgroundColor = UIColor.clear
        cell.detailTextLabel?.backgroundColor = UIColor.clear
        cell.selectedBackgroundView = cellBGColorView
        cell.imageView?.image = image
        cell.layer.borderWidth = 2
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.cornerRadius = 20
        cell.clipsToBounds = true
        cell.textLabel?.text = (lentaRuFeeds.feeds.object(at: indexPath.row) as AnyObject).object(forKey: "title") as? String
        cell.textLabel?.font = UIFont.italicSystemFont(ofSize: 17)
        cell.textLabel?.textColor = UIColor.black
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.lineBreakMode = .byWordWrapping
        cell.detailTextLabel?.text = (lentaRuFeeds.feeds.object(at: indexPath.row) as AnyObject).object(forKey: "pubDate") as? String
        cell.detailTextLabel?.textColor = UIColor.blue
        cell.detailTextLabel?.font = UIFont.italicSystemFont(ofSize: 10)
        
        return cell
    }
    
    func resizeImage(image:UIImage, toTheSize size:CGSize) -> UIImage {

        let scale = CGFloat(max(size.width/image.size.width,
                                size.height/image.size.height))
        let width: CGFloat  = image.size.width * scale
        let height: CGFloat = image.size.height * scale;

        let frame: CGRect = CGRect(x: 0, y: 0, width: width, height: height)

        UIGraphicsBeginImageContextWithOptions(size, false, 0);
        image.draw(in: frame)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext();
        return newImage!
    }
    
}
