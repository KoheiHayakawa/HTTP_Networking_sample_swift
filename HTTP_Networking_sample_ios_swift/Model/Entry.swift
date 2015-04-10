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

class Entry: Mappable, Printable {
    
    var id: Int?
    var title: String?
    var body: String?
    var description: String {
        
        let id: Int = self.id ?? -1
        let title: String = self.title ?? "nil"
        let body: String = self.body ?? "nil"
        
        return "id: \(id), title: \(title), body: \(body)"
    }
    
    required init(){}
    
    required init?(_ map: Map) {
        mapping(map)
    }
    
    func mapping(map: Map) {
        id    <- map["id"]
        title <- map["title"]
        body  <- map["body"]
    }
    
    class func get(#success: [Entry] -> Void, failure: NSError? -> Void) {
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
    
    class func get(#id: Int, success: Entry -> Void, failure: NSError? -> Void) {
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
    
    func create(#success: Void -> Void, failure: NSError? -> Void) {
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
    
    func update(#success: Void -> Void, failure: NSError? -> Void) {
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
    
    func delete(#success: Void -> Void, failure: NSError? -> Void) {
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