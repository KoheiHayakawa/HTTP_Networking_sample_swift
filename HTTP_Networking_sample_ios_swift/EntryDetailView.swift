//
//  EntryDetailView.swift
//  HTTP_Networking_sample_ios_swift
//
//  Created by Kohei Hayakawa on 4/2/15.
//  Copyright (c) 2015 Kohei Hayakawa. All rights reserved.
//

import UIKit

class EntryDetailView: UIView {
    
    private let titleLabel = UILabel()
    private let bodyLabel = UILabel()
    
    var entry: Entry? {
        didSet {
            if let entry: Entry = self.entry {
                titleLabel.text = entry.title
                bodyLabel.text = entry.body
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.whiteColor()
        
        titleLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        addSubview(titleLabel)
        addConstraints([
            NSLayoutConstraint(
                item: titleLabel,
                attribute: .Left,
                relatedBy: .Equal,
                toItem: self,
                attribute: .Left,
                multiplier: 1,
                constant: 10),
            NSLayoutConstraint(
                item: titleLabel,
                attribute: .Right,
                relatedBy: .Equal,
                toItem: self,
                attribute: .Right,
                multiplier: 1,
                constant: -10),
            NSLayoutConstraint(
                item: titleLabel,
                attribute: .Top,
                relatedBy: .Equal,
                toItem: self,
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
        addSubview(bodyLabel)
        addConstraints([
            NSLayoutConstraint(
                item: bodyLabel,
                attribute: .Left,
                relatedBy: .Equal,
                toItem: self,
                attribute: .Left,
                multiplier: 1,
                constant: 10),
            NSLayoutConstraint(
                item: bodyLabel,
                attribute: .Right,
                relatedBy: .Equal,
                toItem: self,
                attribute: .Right,
                multiplier: 1,
                constant: -10),
            NSLayoutConstraint(
                item: bodyLabel,
                attribute: .Top,
                relatedBy: .Equal,
                toItem: self,
                attribute: .Top,
                multiplier: 1,
                constant: 144)]
        )
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
