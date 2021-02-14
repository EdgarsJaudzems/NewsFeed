//
//  NewsTableViewCell.swift
//  NewsFeed
//
//  Created by Edgars Jaudzems on 13/02/2021.
//

import UIKit
import Gloss

class NewsTableViewCell: UITableViewCell {

    
    
    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var newsLabelView: UILabel!
    
    func showImage(with: Item) {
        newsImageView.downloaded(from: with.urlToImage)
    }
    
    func setUI(with: Item) {
        newsLabelView.text = with.title
    }
}


