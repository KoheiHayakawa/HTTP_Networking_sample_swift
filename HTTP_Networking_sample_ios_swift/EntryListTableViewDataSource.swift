//
//  EntryListTableViewDataSource.swift
//  HTTP_Networking_sample_ios_swift
//
//  Created by Kohei Hayakawa on 4/2/15.
//  Copyright (c) 2015 Kohei Hayakawa. All rights reserved.
//

import UIKit

class EntryListTableViewDataSource: NSObject, UITableViewDataSource {
    
    var entries:[Entry] = []
    let cellIdentifier = "CellIdentifier"
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entries.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as UITableViewCell
        let entry = entries[indexPath.row]
        cell.textLabel!.text = entry.title
        return cell
    }
}
