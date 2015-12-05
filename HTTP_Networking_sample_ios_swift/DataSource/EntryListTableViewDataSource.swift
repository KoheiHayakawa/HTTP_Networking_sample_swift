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
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier)! as UITableViewCell
        let entry = entries[indexPath.row]
        cell.textLabel!.text = entry.title
        return cell
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            
            let alert = UIAlertController(
                title: "削除します",
                message: "本当によろしいですか？",
                preferredStyle: .Alert)
            alert.addAction(UIAlertAction(
                title: "削除する",
                style: .Default,
                handler: {action in
                    let entry = self.entries[indexPath.row]
                    entry.deleteEntry(
                        success: {
                            print("success delete")
                        },
                        failure: {(error) in
                            print(error)
                            print("fail delete")
                        }
                    )
                    return
            }))
            alert.addAction(UIAlertAction(title: "キャンセル", style: .Cancel, handler: nil))
            //presentViewController(alert, animated: true, completion: nil)
            
            
            let entry = entries[indexPath.row]
            entry.deleteEntry(
                success: {
                    print("success delete")
                },
                failure: {(error) in
                    print(error)
                    print("fail delete")
                }
            )
            entries.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }
}
