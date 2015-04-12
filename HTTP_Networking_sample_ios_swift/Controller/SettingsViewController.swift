//
//  SettingsViewController.swift
//  HTTP_Networking_sample_ios_swift
//
//  Created by Kohei Hayakawa on 4/12/15.
//  Copyright (c) 2015 Kohei Hayakawa. All rights reserved.
//

import UIKit
import KHAForm

class SettingsViewController: KHAForm {

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Settings"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - KHAForm delegate
    
    override func formCellsInForm(form: KHAForm) -> [[KHAFormCell]] {
        
        // setup cells
        //let cell1 = initFormCellWithType(.TextField) as! KHATextFieldFormCell
        //let cell2 = initFormCellWithType(.TextView) as! KHATextViewFormCell
        let cell3 = initFormCellWithType(.Button) as! KHAButtonFormCell
        
        // settings for each cell
//        cell1.textField.text = entry?.title
//        cell1.textField.placeholder = "Title"
//        cell1.textField.clearButtonMode = UITextFieldViewMode.Always
//        
//        cell2.textView.text = entry?.body
//        cell2.textView.placeholder = "Body"
        
        cell3.button.setTitle("Sign out", forState: .Normal)
        cell3.button.setTitleColor(UIColor.darkGrayColor(), forState: .Normal)
        cell3.button.addTarget(self, action: Selector("didTouchSignOutButton:"), forControlEvents: UIControlEvents.TouchUpInside)
        
        return [[cell3]]
    }
    
    
    // MARK: - Button action selector
    
    func didTouchSignOutButton(sender: UIBarButtonItem) {
        UserManager.signOut()
        let viewController = FirstViewFactory.viewController()
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.changeRootViewController(viewController)
    }

}
