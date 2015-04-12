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
        if !UserManager.isSingIn {
            let viewController = EntryListTableViewController()
            let navigationController = UINavigationController(rootViewController: viewController)
            return navigationController
        } else {
            return SignInViewController()
        }
    }
    
}