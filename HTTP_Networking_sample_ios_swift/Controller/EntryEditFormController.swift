//
//  EntryEditForm.swift
//  HTTP_Networking_sample_ios_swift
//
//  Created by Kohei Hayakawa on 4/2/15.
//  Copyright (c) 2015 Kohei Hayakawa. All rights reserved.
//

import UIKit
import KHAForm

class EntryEditFormController: KHAFormViewController {
    
    var entry: Entry?
    
    
    // MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Edit Entry"
        
        let closeButton = UIBarButtonItem(barButtonSystemItem: .Cancel, target: self, action: "didTouchCloseBarButton:")
        navigationItem.leftBarButtonItem = closeButton
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: "didTouchDoneBarButton:")
        navigationItem.rightBarButtonItem = doneButton
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - KHAForm data source
    
    override func formCellsInForm(form: KHAFormViewController) -> [[KHAFormCell]] {
        
        // setup cells
        let cell1 = dequeueReusableFormCellWithType(.TextField)
        let cell2 = dequeueReusableFormCellWithType(.TextView)
        let cell3 = dequeueReusableFormCellWithType(.Button)
        
        // settings for each cell
        cell1.textField.text = entry?.title
        cell1.textField.placeholder = "Title"
        cell1.textField.clearButtonMode = UITextFieldViewMode.Always
        
        cell2.textView.text = entry?.body
        cell2.textView.placeholder = "Body"
        
        cell3.button.setTitle("Delete", forState: .Normal)
        cell3.button.setTitleColor(UIColor.redColor(), forState: .Normal)
        cell3.button.addTarget(self, action: Selector("didTouchDeleteButton:"), forControlEvents: UIControlEvents.TouchUpInside)
        
        return [[cell1], [cell2], [cell3]]
    }
    
    
    // MARK: - Bar button action selector
    
    func didTouchCloseBarButton(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func didTouchDoneBarButton(sender: UIBarButtonItem) {
        
        let cell1 = formCellForIndexPath(NSIndexPath(forRow: 0, inSection: 0))
        let cell2 = formCellForIndexPath(NSIndexPath(forRow: 0, inSection: 1))
        
        entry?.title = cell1.textField.text
        entry?.body = cell2.textView.text
        
        entry?.updateEntry(
            success: {
                print("success update")
                let userInfo = ["entry" : self.entry!]
                NSNotificationCenter.defaultCenter().postNotificationName(KHASuccessEditEntry, object: nil, userInfo: userInfo)
            },
            failure: {error in
                print("fail update")
            }
        )

        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func didTouchDeleteButton(sender: UIBarButtonItem) {
        
        let removeHandler: AlertActionHandler = {_ in
            self.entry?.deleteEntry(
                success: {
                    print("success delete")
                    NSNotificationCenter.defaultCenter().postNotificationName(KHADeleteEntryAtEditForm, object: nil)
                    self.dismissViewControllerAnimated(true, completion: nil)
                },
                failure: {(error) in
                    print(error)
                    print("fail delete")
                }
            )
            return
        }
        Alert.showEntryRemoveAlert(self, removeHandler: removeHandler)
    }
    
}
