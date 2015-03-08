//
//  MasterViewController.swift
//  HTTP_Networking_sample_ios_swift
//
//  Created by Kohei Hayakawa on 3/8/15.
//  Copyright (c) 2015 Kohei Hayakawa. All rights reserved.
//

import UIKit

class EntryListTableViewController: UITableViewController {

    var entries:[Entry] = []

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshData()

        self.navigationItem.leftBarButtonItem = self.editButtonItem()

        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "insertNewObject:")
        self.navigationItem.rightBarButtonItem = addButton
        
        // pull to reflesh
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.addTarget(self, action: Selector("onRefresh:"), forControlEvents: UIControlEvents.ValueChanged)
        
//        Entry.get(id: 1,
//            success: {(entry) in
//                println(entry.title)
//                println("success id")
//            },
//            failure: {(error) in
//                println(error)
//                println("fail id")
//        })
//        
//        
//        let entry = Entry()
//        entry.title = "てすと"
//        entry.body = "ほげ"
//        
//        entry.create(
//            success: {
//                println("success create")
//            },
//            failure: {(error) in
//                println("fail create")
//                println(error)
//            }
//        )
//
//        Entry.get(id: 1,
//            success: {(entry) in
//                entry.title = "お"
//                entry.update(
//                    success: {
//                        println("success update")
//                    },
//                    failure: {error in
//                        println("fail update")
//                    }
//                )
//                println("success id")
//            },
//            failure: {(error) in
//                println(error)
//                println("fail id")
//            }
//        )
//
//        Entry.get(id: 1,
//            success: {(entry) in
//                entry.delete(
//                    success: {(entry) in
//                        println("success delete")
//                    },
//                    failure: {(error) in
//                        println(error)
//                        println("fail delete")
//                    }
//                )
//                println("success id")
//            },
//            failure: {(error) in
//                println(error)
//                println("fail id")
//            }
//        )
//
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    private func refreshData() {
        
        self.refreshControl?.beginRefreshing()
        
        Entry.get(
            success: {(entries) in
                self.entries = entries.reverse()
                self.tableView.reloadData()
                self.tableView.reloadSections(NSIndexSet(index: 0), withRowAnimation: UITableViewRowAnimation.Automatic)
                self.refreshControl?.endRefreshing()
                println("success all")
            },
            failure: {(error) in
                self.refreshControl?.endRefreshing()
                println(error)
                println("fail all")
            }
        )
    }
    
    func onRefresh(sender: UIRefreshControl) {
        refreshData()
    }

    func insertNewObject(sender: AnyObject) {
        //objects.insertObject(NSDate(), atIndex: 0)
        //let indexPath = NSIndexPath(forRow: 0, inSection: 0)
        //self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
    }

    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow() {
                let entry = entries[indexPath.row]
            (segue.destinationViewController as EntryDetailViewController).entry = entry
            }
        }
    }

    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entries.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell

        let entry = entries[indexPath.row]
        cell.textLabel!.text = entry.title
        return cell
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            let entry = entries[indexPath.row]
            entry.delete(
                success: {(tweet) in
                    println("success delete")
                },
                failure: {(error) in
                    println(error)
                    println("fail delete")
                }
            )
            entries.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }


}

