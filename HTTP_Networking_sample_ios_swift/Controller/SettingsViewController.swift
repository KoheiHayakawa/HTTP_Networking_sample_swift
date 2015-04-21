//
//  SettingsViewController.swift
//  HTTP_Networking_sample_ios_swift
//
//  Created by Kohei Hayakawa on 4/12/15.
//  Copyright (c) 2015 Kohei Hayakawa. All rights reserved.
//

import UIKit
import KHAForm

class SettingsViewController: KHAFormViewController, KHAFormViewDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Settings"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - KHAForm data source
    
    override func formCellsInForm(form: KHAFormViewController) -> [[KHAFormCell]] {
        
        // setup cells
        let cell1 = KHAFormCell(style: .Value2, reuseIdentifier: "cell")
        let cell2 = dequeueReusableFormCellWithType(.Button)
        
        // settings for each cell
        cell1.textLabel?.text = "Email"
        cell1.detailTextLabel?.text = UserManager.email
        
        cell2.button.setTitle("Sign out", forState: .Normal)
        cell2.button.setTitleColor(UIColor.darkGrayColor(), forState: .Normal)
        cell2.button.addTarget(self, action: Selector("didTouchSignOutButton:"), forControlEvents: UIControlEvents.TouchUpInside)
        
        return [[cell1], [cell2]]
    }
    
    
    // MARK: - Button action selector
    
    func didTouchSignOutButton(sender: UIBarButtonItem) {
        UserManager.signOut()
        let viewController = RootViewFactory.viewController()
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.changeRootViewController(viewController)
    }

}
