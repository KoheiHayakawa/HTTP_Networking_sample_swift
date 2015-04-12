//
//  RootViewFactory.swift
//  HTTP_Networking_sample_ios_swift
//
//  Created by Kohei Hayakawa on 4/12/15.
//  Copyright (c) 2015 Kohei Hayakawa. All rights reserved.
//

import UIKit

class RootViewFactory: NSObject {
    
    class func viewController() -> UIViewController {
        if UserManager.isSingIn {
            
            let entryListTableViewController = EntryListTableViewController()
            let navigationController1 = UINavigationController(rootViewController: entryListTableViewController)
            navigationController1.tabBarItem = UITabBarItem(title: "Entries", image: nil, tag: 0)

            let settingsViewController = SettingsViewController()
            let navigationController2 = UINavigationController(rootViewController: settingsViewController)
            navigationController2.tabBarItem = UITabBarItem(title: "Settings", image: nil, tag: 1)
            
            let tabBarController = UITabBarController()
            tabBarController.setViewControllers([navigationController1, navigationController2], animated: false)
            
            return tabBarController
            
        } else {
            return SignInViewController()
        }
    }
    
}