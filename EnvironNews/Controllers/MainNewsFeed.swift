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
    
    override func viewDidLoad() {
        super.viewDidLoad();
        backgroundView.backgroundColor = Colors.offWhiteColor;
        pullNewsArticles();
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
                        print(response)
                        print("============================")
                    }
                } else {
                    print("computer")
                }
            }
        }
    }

}
