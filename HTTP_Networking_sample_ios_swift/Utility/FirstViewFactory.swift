//
//  FirstViewFactory.swift
//  HTTP_Networking_sample_ios_swift
//
//  Created by Kohei Hayakawa on 4/12/15.
//  Copyright (c) 2015 Kohei Hayakawa. All rights reserved.
//

import UIKit

class FirstViewFactory: NSObject {
    
    class func viewController() -> UIViewController {
        if UserManager.isSingIn {
            
            let entryListTableViewController = EntryListTableViewController()
            let navigationController1 = UINavigationController(rootViewController: entryListTableViewController)

            let settingsViewController = SettingsViewController()
            let navigationController2 = UINavigationController(rootViewController: settingsViewController)

            let tabBarController = UITabBarController()
            tabBarController.setViewControllers([navigationController1, navigationController2], animated: false)
            
            return tabBarController
            
        } else {
            return SignInViewController()
        }
    }
    
}