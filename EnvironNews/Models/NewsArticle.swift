//
//  NewsArticle.swift
//  EnvironNews
//
//  Created by Will Cohen on 12/11/17.
//  Copyright © 2017 Will Cohen. All rights reserved.
//

import Foundation

class NewsArticle {
    
    var source: String!
    var title: String!
    var description: String?
    var URL: String!
    var imageURL: String!
    var date: String!
    
    init(source: String, title: String, description: String, URL: String, imageURL: String, date: String) {
        self.source = source;
        self.title = title;
        self.description = description;
        self.URL = URL;
        self.imageURL = imageURL;
        self.date = date;
    }
    
    init(source: String, title: String, URL: String, imageURL: String, date: String) {
        self.source = source;
        self.title = title;
        self.URL = URL;
        self.imageURL = imageURL;
        self.date = date;
    }
    
}
