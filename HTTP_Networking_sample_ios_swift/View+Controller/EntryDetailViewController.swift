//
//  DetailViewController.swift
//  HTTP_Networking_sample_ios_swift
//
//  Created by Kohei Hayakawa on 3/8/15.
//  Copyright (c) 2015 Kohei Hayakawa. All rights reserved.
//

import UIKit

class EntryDetailViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    
    var entryDetailView: EntryDetailView?

    var entry: Entry? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }

    func configureView() {
        // Update the user interface for the detail item.
        if let entry: Entry = self.entry {
            if let titleLabel = self.titleLabel {
                titleLabel.text = entry.title
            }
            if let bodyLabel = self.bodyLabel {
                bodyLabel.text = entry.body
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Entry Detail";
        entryDetailView = EntryDetailView(frame: view.frame)
        view.addSubview(entryDetailView!)
        
        //self.shopDetailView = [[ShopDetailView alloc] initWithFrame:self.view.frame];
        //self.shopDetailView.delegate = self;
        
        //self.shopDetailView.shop = self.shop;
        
        //[self.view addSubview:self.shopDetailView];
        
        // Do any additional setup after loading the view, typically from a nib.
        //self.configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

