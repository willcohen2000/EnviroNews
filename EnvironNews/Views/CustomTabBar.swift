//
//  CustomTabBar.swift
//  EnvironNews
//
//  Created by Will Cohen on 12/12/17.
//  Copyright © 2017 Will Cohen. All rights reserved.
//

import UIKit

class CustomTabBar: UITabBarController {
    
    override func viewWillLayoutSubviews() {
        var tabFrame = self.tabBar.frame;
        tabFrame.size.height = 65;
        tabFrame.origin.y = self.view.frame.size.height - 65;
        self.tabBar.frame = tabFrame;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        (tabBar.items![0]).selectedImage = UIImage(named: "BookFilled")?.withRenderingMode(.alwaysOriginal);
        (tabBar.items![1]).selectedImage = UIImage(named: "AccountFilled")?.withRenderingMode(.alwaysOriginal);
        (tabBar.items![2]).selectedImage = UIImage(named: "SettingsFilled")?.withRenderingMode(.alwaysOriginal);
        
        
        tabBar.unselectedItemTintColor = UIColor.white;
        tabBar.barTintColor = UIColor.white;
        UITabBar.appearance().shadowImage = UIImage();
        UITabBar.appearance().backgroundImage = UIImage();
        self.selectedIndex = 2;
        for vc in self.viewControllers! {
            vc.tabBarItem.title = nil;
            vc.tabBarItem.imageInsets = UIEdgeInsetsMake(5, 0, -5, 0);
        }
        
        
        
    }
    
}
