//
//  MasterViewController.swift
//  HTTP_Networking_sample_ios_swift
//
//  Created by Kohei Hayakawa on 3/8/15.
//  Copyright (c) 2015 Kohei Hayakawa. All rights reserved.
//

import UIKit

class EntryListTableViewController: UITableViewController {

    let dataSource = EntryListTableViewDataSource()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Entry List"
        
        tableView.delegate = self
        tableView.dataSource = dataSource
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: dataSource.cellIdentifier)
        
        navigationItem.leftBarButtonItem = editButtonItem()

        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "didTouchedEntryCreationBarButton:")
        navigationItem.rightBarButtonItem = addButton
        
        // pull to reflesh
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: Selector("onRefresh:"), forControlEvents: UIControlEvents.ValueChanged)
        
        refreshData()

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
                self.dataSource.entries = entries.reverse()
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
    
    func onRefresh(sender: UIRefreshControl) {
        refreshData()
    }

    
    // MARK: - TableViewDelegate
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let entry = dataSource.entries[indexPath.row]
        let entryDetailViewController = EntryDetailViewController()
        entryDetailViewController.entry = entry
        navigationController?.pushViewController(entryDetailViewController, animated: true)
    }

    
    // MARK: - Bar button action selector
    
    func didTouchedEntryCreationBarButton(sender: UIBarButtonItem) {
        let entryCreationForm = EntryCreationForm()
        let navigationController = UINavigationController(rootViewController: entryCreationForm)
        presentViewController(navigationController, animated: true, completion: nil)
    }
    
}

