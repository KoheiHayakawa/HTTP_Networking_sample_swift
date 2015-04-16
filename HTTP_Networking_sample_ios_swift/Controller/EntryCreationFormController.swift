//
//  EntryCreationForm.swift
//  HTTP_Networking_sample_ios_swift
//
//  Created by Kohei Hayakawa on 4/2/15.
//  Copyright (c) 2015 Kohei Hayakawa. All rights reserved.
//

import UIKit
import KHAForm

class EntryCreationFormController: KHAFormController, KHAFormDataSource {

    
    // MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Create Entry"
        
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

    override func formCellsInForm(form: KHAFormController) -> [[KHAFormCell]] {
        
        // setup cells
        let cell1 = KHAFormCell.formCellWithType(.TextField)
        let cell2 = KHAFormCell.formCellWithType(.TextView)
        
        // settings for each cell
        cell1.textField.placeholder = "Title"
        cell1.textField.clearButtonMode = UITextFieldViewMode.Always
        
        cell2.textView.placeholder = "Body"

        return [[cell1], [cell2]]
    }

    
    // MARK: - Bar button action selector

    func didTouchCloseBarButton(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func didTouchDoneBarButton(sender: UIBarButtonItem) {
        
        let cell1 = formCellForIndexPath(NSIndexPath(forRow: 0, inSection: 0))
        let cell2 = formCellForIndexPath(NSIndexPath(forRow: 0, inSection: 1))
        
        let entry = Entry()
        entry.title = cell1.textField.text
        entry.body = cell2.textView.text
        
        entry.createEntry(
            success: {
                println("success create")
            },
            failure: {(error) in
                println("fail create")
                println(error)
            }
        )
        dismissViewControllerAnimated(true, completion: nil)
    }

}
