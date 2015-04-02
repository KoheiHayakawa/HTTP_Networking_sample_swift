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
    var entryDetailView: EntryDetailView?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Entry Detail";
        entryDetailView = EntryDetailView(frame: view.frame)
        entryDetailView?.entry = entry
        view.addSubview(entryDetailView!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

