//
//  Entry.swift
//  HTTP_Networking_sample_ios_swift
//
//  Created by Kohei Hayakawa on 3/8/15.
//  Copyright (c) 2015 Kohei Hayakawa. All rights reserved.
//

import UIKit
import ObjectMapper
import SwiftyJSON

class Entry: Common {
    
    var id: Int?
    var title: String?
    var body: String?
    
    override func mapping(map: Map) {
        id    <- map["id"]
        title <- map["title"]
        body  <- map["body"]
    }
    
    class func getEntries(#success: [Entry] -> Void, failure: NSError? -> Void) {
        let completionHandler: AlamofireCompletionHandler = {_, _, data, error in
            if let error = error {
                failure(error)
                return
            }
            let json = JSON(data!)
            let entries = json.arrayValue.map{(json) -> Entry in
                return Mapper<Entry>().map(json.dictionaryObject!)!
            }
            success(entries)
            return
        }
        Request.get(path: .Entries, completionHandler: completionHandler)
    }
    
    class func getEntryByID(id: Int, success: Entry -> Void, failure: NSError? -> Void) {
        let completionHandler: AlamofireCompletionHandler = {_, _, data, error in
            if let error = error {
                failure(error)
                return
            }
            let json = JSON(data!)
            let entry = Mapper<Entry>().map(json.dictionaryObject!)!
            success(entry)
            return
        }
        let query = "/\(id)"
        Request.get(path: .Entries, query: query, completionHandler: completionHandler)
    }
    
    func createEntry(#success: Void -> Void, failure: NSError? -> Void) {
        let completionHandler: AlamofireCompletionHandler = {_, _, data, error in
            if let error = error {
                failure(error)
                return
            }
            if let data: AnyObject = data {
                success()
                return
            }
            failure(nil)
        }
        let params: [String: AnyObject] = [
            "title" : self.title!,
            "body"  : self.body!
        ]
        Request.post(path: .Entries, params: params, completionHandler: completionHandler)
    }
    
    func updateEntry(#success: Void -> Void, failure: NSError? -> Void) {
        let completionHandler: AlamofireCompletionHandler = {_, _, data, error in
            if let error = error {
                failure(error)
                return
            }
            if let data: AnyObject = data {
                success()
                return
            }
            failure(nil)
        }
        let params: [String: AnyObject] = [
            "title" : self.title!,
            "body"  : self.body!
        ]
        let query = "/\(self.id!)"
        Request.update(path: .Entries, query: query, params: params, completionHandler: completionHandler)
    }
    
    func deleteEntry(#success: Void -> Void, failure: NSError? -> Void) {
        let completionHandler: AlamofireCompletionHandler = {_, _, data, error in
            if let error = error {
                failure(error)
                return
            }
            success()
            return
        }
        let query = "/\(self.id!)"
        Request.delete(path: .Entries, query: query, completionHandler: completionHandler)
    }
    
}