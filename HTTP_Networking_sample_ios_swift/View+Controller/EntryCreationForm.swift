//
//  EntryCreationForm.swift
//  HTTP_Networking_sample_ios_swift
//
//  Created by Kohei Hayakawa on 4/2/15.
//  Copyright (c) 2015 Kohei Hayakawa. All rights reserved.
//

import UIKit

class EntryCreationForm: KHAForm {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // override a method to determine form structure
    override func formCellsInForm(form: KHAForm) -> [[KHAFormCell]] {
        
        // setup cells
        let cell1 = initFormCellWithType(.TextField) as KHATextFieldFormCell
        let cell2 = initFormCellWithType(.TextView) as KHATextViewFormCell
        
        // settings for each cell
        cell1.textField.placeholder = "Title"
        cell1.textField.clearButtonMode = UITextFieldViewMode.Always
        
        cell2.textView.placeholder = "Body"

        return [[cell1], [cell2]]
    }

}
