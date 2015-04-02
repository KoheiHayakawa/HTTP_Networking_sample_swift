//
//  DetailViewController.swift
//  HTTP_Networking_sample_ios_swift
//
//  Created by Kohei Hayakawa on 3/8/15.
//  Copyright (c) 2015 Kohei Hayakawa. All rights reserved.
//

import UIKit

class EntryDetailViewController: UIViewController {
    
    let titleLabel = UILabel()
    let bodyLabel = UILabel()
    
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
            titleLabel.text = entry.title
            bodyLabel.text = entry.body
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Entry Detail";
        entryDetailView = EntryDetailView(frame: view.frame)
        view.addSubview(entryDetailView!)
        
        titleLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        view.addSubview(titleLabel)
        view.addConstraints([
            NSLayoutConstraint(
                item: titleLabel,
                attribute: .Left,
                relatedBy: .Equal,
                toItem: view,
                attribute: .Left,
                multiplier: 1,
                constant: 10),
            NSLayoutConstraint(
                item: titleLabel,
                attribute: .Right,
                relatedBy: .Equal,
                toItem: view,
                attribute: .Right,
                multiplier: 1,
                constant: -10),
            NSLayoutConstraint(
                item: titleLabel,
                attribute: .Top,
                relatedBy: .Equal,
                toItem: view,
                attribute: .Top,
                multiplier: 1,
                constant: 100),
            NSLayoutConstraint(
                item: titleLabel,
                attribute: .Height,
                relatedBy: .Equal,
                toItem: nil,
                attribute: .NotAnAttribute,
                multiplier: 1,
                constant: 44)]
        )
        
        bodyLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        bodyLabel.numberOfLines = 0
        view.addSubview(bodyLabel)
        view.addConstraints([
            NSLayoutConstraint(
                item: bodyLabel,
                attribute: .Left,
                relatedBy: .Equal,
                toItem: view,
                attribute: .Left,
                multiplier: 1,
                constant: 10),
            NSLayoutConstraint(
                item: bodyLabel,
                attribute: .Right,
                relatedBy: .Equal,
                toItem: view,
                attribute: .Right,
                multiplier: 1,
                constant: -10),
            NSLayoutConstraint(
                item: bodyLabel,
                attribute: .Top,
                relatedBy: .Equal,
                toItem: view,
                attribute: .Top,
                multiplier: 1,
                constant: 144)]
        )
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

