//
//  LandingPageController.swift
//  EnvironNews
//
//  Created by Will Cohen on 11/18/17.
//  Copyright © 2017 Will Cohen. All rights reserved.
//

import UIKit

class LandingPageController: UIViewController {
    
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var logInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad();
        initializeView();
    }
    
    @IBAction func logInButtonPressed(sender: AnyObject) {
        
    }
    
    @IBAction func createAccountButtonPressed(_ sender: Any) {
        
    }
    
    @IBAction func forgotPasswordButtonPressed(_ sender: Any) {
        
    }
    
    private func initializeView() {
        Customization.loginTextFieldCustomization(TF: emailTextField);
        Customization.loginTextFieldCustomization(TF: passwordTextField);
        logInButton.layer.cornerRadius = logInButton.frame.height / 2;
    }

    
}
