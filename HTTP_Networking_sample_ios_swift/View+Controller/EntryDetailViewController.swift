//
//  DetailViewController.swift
//  HTTP_Networking_sample_ios_swift
//
//  Created by Kohei Hayakawa on 3/8/15.
//  Copyright (c) 2015 Kohei Hayakawa. All rights reserved.
//

import UIKit

class EntryDetailViewController: UIViewController {

    var entry: Entry?
    private var entryDetailView: EntryDetailView?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Entry Detail";
        entryDetailView = EntryDetailView(frame: view.frame)
        entryDetailView?.entry = entry
        view.addSubview(entryDetailView!)
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .Edit, target: self, action: "didTouchedEditBarButton:")
        navigationItem.rightBarButtonItem = doneButton
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // MARK: - Bar button action selector
    
    func didTouchedEditBarButton(sender: UIBarButtonItem) {
        let entryEditForm = EntryEditForm()
        entryEditForm.entry = entry
        let navigationController = UINavigationController(rootViewController: entryEditForm)
        presentViewController(navigationController, animated: true, completion: nil)
    }
}

