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

    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Entry Detail";
        entryDetailView = EntryDetailView(frame: view.frame)
        entryDetailView?.entry = entry
        view.addSubview(entryDetailView!)
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .Edit, target: self, action: "didTouchEditBarButton:")
        navigationItem.rightBarButtonItem = doneButton
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "didSuccessEditEntry:",
            name: KHASuccessEditEntry, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "didDeleteEntryAtEditForm:",
            name: KHADeleteEntryAtEditForm, object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Observer must be removed before the object is released
    deinit {
        println("deinit")
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    // MARK: - Bar button action selector
    
    func didTouchEditBarButton(sender: UIBarButtonItem) {
        let entryEditForm = EntryEditForm()
        entryEditForm.entry = entry
        let navigationController = UINavigationController(rootViewController: entryEditForm)
        presentViewController(navigationController, animated: true, completion: nil)
    }
    
    
    // MARK: - Notification selector
    
    func didSuccessEditEntry(notification: NSNotification) {
        if let entry = notification.userInfo?["entry"] as? Entry {
            entryDetailView?.entry = entry
        }
    }
    
    func didDeleteEntryAtEditForm(notification: NSNotification) {
        navigationController?.popViewControllerAnimated(false)
    }
}

