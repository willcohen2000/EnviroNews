//
//  NewsFeedSansImageCell.swift
//  EnvironNews
//
//  Created by Will Cohen on 12/30/17.
//  Copyright © 2017 Will Cohen. All rights reserved.
//

import UIKit

class NewsFeedSansImageCell: UITableViewCell {

    @IBOutlet weak var articleTitle: VerticalTopAlignLabel!
    @IBOutlet weak var articleDescription: VerticalTopAlignLabel!
    
    func buildArticleCell(article: NewsArticle) {
        articleTitle.text = article.title;
        articleDescription.text = article.description;
    }
    
}
