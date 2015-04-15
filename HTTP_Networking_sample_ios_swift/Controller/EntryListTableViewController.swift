//
//  MasterViewController.swift
//  HTTP_Networking_sample_ios_swift
//
//  Created by Kohei Hayakawa on 3/8/15.
//  Copyright (c) 2015 Kohei Hayakawa. All rights reserved.
//

import UIKit

class EntryListTableViewController: UITableViewController {

    private var entries:[Entry] = []
    private let cellIdentifier = "CellIdentifier"

    
    // MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Entries"
        
        tableView.delegate = self
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        
        navigationItem.leftBarButtonItem = editButtonItem()

        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "didTouchEntryCreationBarButton:")
        navigationItem.rightBarButtonItem = addButton
        
        // pull to reflesh
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: Selector("onRefresh:"), forControlEvents: UIControlEvents.ValueChanged)
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        refreshData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    private func refreshData() {
        Entry.getEntries(
            success: {(entries) in
                self.entries = entries.reverse()
                self.tableView.reloadData()
                println("success all")
            },
            failure: {(error) in
                println(error)
                Alert.showNoInternetConnectionAvailableAlertWithTitle("Cannot Get Entries", target: self)
                println("fail all")
            }
        )
    }
    
    func onRefresh(sender: UIRefreshControl) {
        refreshControl?.beginRefreshing()
        Entry.getEntries(
            success: {(entries) in
                self.entries = entries.reverse()
                self.tableView.reloadData()
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

    
    // MARK: - TableViewDataSource

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entries.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as! UITableViewCell
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
            let removeHandler: AlertActionHandler = {_ in
                let entry = self.entries[indexPath.row]
                entry.deleteEntry(
                    success: {
                        println("success delete")
                        self.entries.removeAtIndex(indexPath.row)
                        tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
                    },
                    failure: {(error) in
                        println(error)
                        println("fail delete")
                    }
                )
            }
            Alert.showEntryRemoveAlert(self, removeHandler: removeHandler)
        }
    }
    
    
    // MARK: - TableViewDelegate
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let entry = entries[indexPath.row]
        let entryDetailViewController = EntryDetailViewController()
        entryDetailViewController.entry = entry
        navigationController?.pushViewController(entryDetailViewController, animated: true)
    }

    
    // MARK: - Bar button action selector
    
    func didTouchEntryCreationBarButton(sender: UIBarButtonItem) {
        let entryCreationForm = EntryCreationForm()
        let navigationController = UINavigationController(rootViewController: entryCreationForm)
        presentViewController(navigationController, animated: true, completion: nil)
    }
    
}

