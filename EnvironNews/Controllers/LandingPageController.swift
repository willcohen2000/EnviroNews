//
//  LandingPageController.swift
//  EnvironNews
//
//  Created by Will Cohen on 11/18/17.
//  Copyright © 2017 Will Cohen. All rights reserved.
//

import UIKit;
import Firebase;
import GoogleSignIn;

class LandingPageController: UIViewController {
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var enviroNewsLabel: UILabel!
    @IBOutlet weak var googleSignInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad();
        backgroundView.backgroundColor = Colors.offWhiteColor;
        intializeTexts();
    }
    
    private func intializeTexts() {
        welcomeLabel.font = UIFont(name: "Roboto-Regular", size: 40);
        welcomeLabel.textColor = Colors.offBlackColor;
        welcomeLabel.text = "Welcome to";
        enviroNewsLabel.font = UIFont(name: "Roboto-Medium", size: 40);
        enviroNewsLabel.textColor = Colors.centralGreenColor;
        enviroNewsLabel.text = "EnviroNews";
    }

    @IBAction func signInWithGoogleButtonPressed(_ sender: Any) {
    
    }
    
    
}
