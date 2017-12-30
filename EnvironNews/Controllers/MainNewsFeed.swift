//
//  MainNewsFeed.swift
//  EnvironNews
//
//  Created by Will Cohen on 12/11/17.
//  Copyright © 2017 Will Cohen. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class MainNewsFeed: UIViewController {

    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var newsFeedTableView: UITableView!
    
    var articles = [NewsArticle]();
    var selectedArticle: NewsArticle!
    
    override func viewDidLoad() {
        super.viewDidLoad();
        backgroundView.backgroundColor = Colors.offWhiteColor;
        pullNewsArticles();
        newsFeedTableView.delegate = self;
        newsFeedTableView.dataSource = self;
    }

    private func pullNewsArticles() {
        if let apikey = App.sharedInstance.NewsAPIKey {
            Alamofire.request("https://newsapi.org/v2/everything?q=environmental+technology&sortBy=popularity&language=en&apiKey=\(apikey)").responseJSON { (responseData) -> Void in
                if((responseData.result.value) != nil) {
                    let JSONResponse = JSON(responseData.result.value!);
                    print(JSONResponse)
                    for (subJson):(String, JSON) in JSONResponse["articles"] {
                        let response = subJson.1;
                        let source = response["source"] as JSON;
                        guard let sourceName = source["name"].string else { return };
                        guard let imageURL = response["urlToImage"].string else { return };
                        guard let date = response["publishedAt"].string else { return };
                        guard let title = response["title"].string else { return };
                        guard let description = response["description"].string else { return };
                        guard let url = response["url"].string else { return };
                        self.articles.append(NewsArticle(source: sourceName, title: title, description: description, URL: url, imageURL: imageURL, date: date));
                    }
                } else {
                    print("Error");
                }
                self.newsFeedTableView.reloadData();
                print("HELLLSO")
            }
        }
    }

}

extension MainNewsFeed: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedArticle = self.articles[indexPath.row];
        self.performSegue(withIdentifier: "toArticle", sender: nil);
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 156.0;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let article = articles[indexPath.row]
        if let articleCell = newsFeedTableView.dequeueReusableCell(withIdentifier: "articleWithImage") as? NewsFeedCellWithImage {
            articleCell.buildArticleCell(article: article);
            return articleCell;
        } else {
            return NewsFeedCellWithImage()
        }
    }
    
}

extension MainNewsFeed {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toArticle") {
            if let articleVC = segue.destination as? ArticleController {
                articleVC.articleURL = self.selectedArticle.URL;
            }
        }
    }
}





