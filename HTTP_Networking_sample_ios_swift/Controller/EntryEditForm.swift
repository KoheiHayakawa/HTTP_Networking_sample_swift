//
//  EntryEditForm.swift
//  HTTP_Networking_sample_ios_swift
//
//  Created by Kohei Hayakawa on 4/2/15.
//  Copyright (c) 2015 Kohei Hayakawa. All rights reserved.
//

import UIKit
import KHAForm

class EntryEditForm: KHAForm {
    
    var entry: Entry?
    
    
    // MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Edit Entry"
        
        let closeButton = UIBarButtonItem(barButtonSystemItem: .Cancel, target: self, action: "didTouchedCloseBarButton:")
        navigationItem.leftBarButtonItem = closeButton
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: "didTouchedDoneBarButton:")
        navigationItem.rightBarButtonItem = doneButton
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - KHAForm delegate
    
    override func formCellsInForm(form: KHAForm) -> [[KHAFormCell]] {
        
        // setup cells
        let cell1 = initFormCellWithType(.TextField) as! KHATextFieldFormCell
        let cell2 = initFormCellWithType(.TextView) as! KHATextViewFormCell
        let cell3 = initFormCellWithType(.Button) as! KHAButtonFormCell
        
        // settings for each cell
        cell1.textField.text = entry?.title
        cell1.textField.placeholder = "Title"
        cell1.textField.clearButtonMode = UITextFieldViewMode.Always
        
        cell2.textView.text = entry?.body
        cell2.textView.placeholder = "Body"
        
        cell3.button.setTitle("Delete", forState: .Normal)
        cell3.button.setTitleColor(UIColor.redColor(), forState: .Normal)
        cell3.button.addTarget(self, action: Selector("didTouchedDeleteButton:"), forControlEvents: UIControlEvents.TouchUpInside)
        
        return [[cell1], [cell2], [cell3]]
    }
    
    
    // MARK: - Bar button action selector
    
    func didTouchedCloseBarButton(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func didTouchedDoneBarButton(sender: UIBarButtonItem) {
        
        let cell1 = formCellForIndexPath(NSIndexPath(forRow: 0, inSection: 0)) as! KHATextFieldFormCell
        let cell2 = formCellForIndexPath(NSIndexPath(forRow: 0, inSection: 1)) as! KHATextViewFormCell
        
        entry?.title = cell1.textField.text
        entry?.body = cell2.textView.text
        
        entry?.updateEntry(
            success: {
                println("success update")
                let userInfo = ["entry" : self.entry!]
                NSNotificationCenter.defaultCenter().postNotificationName(KHASuccessEditEntry, object: nil, userInfo: userInfo)
            },
            failure: {error in
                println("fail update")
            }
        )

        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func didTouchedDeleteButton(sender: UIBarButtonItem) {
        
        let removeHandler: AlertActionHandler = {_ in
            self.entry?.deleteEntry(
                success: {
                    println("success delete")
                    let navigationController = UIApplication.sharedApplication().keyWindow?.rootViewController as! UINavigationController
                    navigationController.popViewControllerAnimated(false)
                    self.dismissViewControllerAnimated(true, completion: nil)
                },
                failure: {(error) in
                    println(error)
                    println("fail delete")
                }
            )
            return
        }
        Alerts.showEntryRemoveAlert(self, removeHandler: removeHandler)
    }
    
}
