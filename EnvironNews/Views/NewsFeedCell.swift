//
//  NewsFeedCell.swift
//  EnvironNews
//
//  Created by Will Cohen on 12/30/17.
//  Copyright © 2017 Will Cohen. All rights reserved.
//

import UIKit
import SDWebImage

class NewsFeedCellWithImage: UITableViewCell {

    @IBOutlet weak var articleImage: UIImageView!
    @IBOutlet weak var articleTitle: VerticalTopAlignLabel!
    @IBOutlet weak var articleDescription: VerticalTopAlignLabel!
    
    func buildArticleCell(article: NewsArticle) {
        articleImage.sd_setImage(with: URL(string: article.imageURL), completed: nil);
        articleTitle.text = article.title;
        articleDescription.text = article.description;
    }
    
}
