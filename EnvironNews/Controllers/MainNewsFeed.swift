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
import Firebase

class MainNewsFeed: UIViewController {

    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var newsFeedTableView: UITableView!
    
    var articles = [NewsArticle]();
    var selectedArticle: NewsArticle!
    var blacklistedArticleURLs = [String]();
    let currentUserUID = Auth.auth().currentUser?.uid
    
    override func viewDidLoad() {
        super.viewDidLoad();
        backgroundView.backgroundColor = Colors.offWhiteColor;
        pullNewsArticles();
        newsFeedTableView.delegate = self;
        newsFeedTableView.dataSource = self;
    }

    private func pullBlacklist(completionHandler: @escaping (_ success: Bool?) -> Void) {
        let blacklistReference = Database.database().reference().child("App").child("Blacklist");
        blacklistReference.observeSingleEvent(of: .value, with: { (snapshot) in
            if let snapshot = snapshot.children.allObjects as? [DataSnapshot] {
                for (snap) in snapshot {
                    if let snapVal = snap.value {
                        self.blacklistedArticleURLs.append(snapVal as! String);
                        print(self.blacklistedArticleURLs)
                    }
                }
            }
            completionHandler(true);
        }) { (error) in
            completionHandler(false);
        }
    }
    
    private func printResponse(response: JSON) {
        print("===================================================");
        print("===================================================");
        print("===================================================");
        print(response);
        print("===================================================");
        print("===================================================");
        print("===================================================");
    }
    
    private func saveArticle(article: NewsArticle) {
        let savedArticlesReference = Database.database().reference().child("SavedArticles").child(currentUserUID!).childByAutoId();
        savedArticlesReference.updateChildValues([
            "title": article.title,
            "description": article.description!,
            "URL": article.URL,
            "imageURL": article.imageURL
        ]) { (error, reference) in
            if let error = error {
                print("@willcohen: \(error)");
            }
        }
    }
    
    private func pullNewsArticles() {
        pullBlacklist { (success) in
            if (success)! {
                if let apikey = App.sharedInstance.NewsAPIKey {
                    Alamofire.request("https://newsapi.org/v2/everything?q=environmental+technology&sortBy=popularity&language=en&apiKey=\(apikey)").responseJSON { (responseData) -> Void in
                        if((responseData.result.value) != nil) {
                            let JSONResponse = JSON(responseData.result.value!);
                            self.printResponse(response: JSONResponse);
                            for (subJson):(String, JSON) in JSONResponse["articles"] {
                                let response = subJson.1;
                                let source = response["source"] as JSON;
                                guard let sourceName = source["name"].string else { return };
                                guard let imageURL = response["urlToImage"].string else { return };
                                guard let date = response["publishedAt"].string else { return };
                                guard let title = response["title"].string else { return };
                                guard let description = response["description"].string else { return };
                                guard let url = response["url"].string else { return };
                                if (!self.blacklistedArticleURLs.contains(description)) {
                                    self.articles.append(NewsArticle(source: sourceName, title: title, description: description, URL: url, imageURL: imageURL, date: date));
                                }
                            }
                        } else {
                            print("Error");
                        }
                        self.newsFeedTableView.reloadData();
                    }
                }
            } else {
                // ERRRRR
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
    
    func tableView(_ tableView: UITableView, editActionsForRowAt: IndexPath) -> [UITableViewRowAction]? {
        let favorite = UITableViewRowAction(style: .normal, title: "Bookmark Article") { action, index in
            self.saveArticle(article: self.articles[editActionsForRowAt.row]);
        }
        favorite.backgroundColor = Colors.offGreenColor;
        return [favorite];
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let article = articles[indexPath.row]
        if (article.imageURL == "") {
            if let articleCell = newsFeedTableView.dequeueReusableCell(withIdentifier: "articleSansImage") as? NewsFeedSansImageCell {
                articleCell.buildArticleCell(article: article);
                return articleCell;
            } else {
                return NewsFeedSansImageCell();
            }
        } else {
            if let articleCell = newsFeedTableView.dequeueReusableCell(withIdentifier: "articleWithImage") as? NewsFeedCellWithImage {
                articleCell.buildArticleCell(article: article);
                return articleCell;
            } else {
                return NewsFeedCellWithImage();
            }
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





