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

class Entry: Mappable {
    
    var id: Int?
    var title: String?
    var body: String?
    
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
            let tweetsJson = JSON(data!)
            let result = tweetsJson.arrayValue.map{(json) -> Entry in
                return Mapper<Entry>().map(json.dictionaryObject!)
            }
            success(result)
            return
        }
        Request().get(path: .Entries, completionHandler: completionHandler)
    }
    
    class func get(#id: Int, success: Entry -> Void, failure: NSError? -> ()) {
        let completionHandler: AlamofireCompletionHandler = {_, _, data, error in
            if let error = error {
                failure(error)
                return
            }
            let tweetJson = JSON(data!)
            let result = Mapper<Entry>().map(tweetJson.dictionaryObject!)
            success(result)
            return
        }
        let query = "/\(id)"
        Request().get(path: .Entries, query: query, completionHandler: completionHandler)
    }
    
    func create(#success: Void -> Void, failure: NSError? -> Void) {
        let completionHandler: AlamofireCompletionHandler = {_, _, json, error in
            if let error = error {
                failure(error)
                return
            }
            if let json: AnyObject = json {
                success()
                return
            }
            failure(nil)
        }
        let params: [String: AnyObject] = [
            "title" : self.title!,
            "body"  : self.body!
        ]
        Request().post(path: .Entries, params: params, completionHandler: completionHandler)
    }
    
    func update(#success: Void -> Void, failure: NSError? -> Void) {
        let completionHandler: AlamofireCompletionHandler = {_, _, json, error in
            if let error = error {
                failure(error)
                return
            }
            if let json: AnyObject = json {
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
        Request().update(path: .Entries, query: query, params: params, completionHandler: completionHandler)
    }
    
    func delete(#success: Void -> Void, failure: NSError? -> Void) {
        let completionHandler: AlamofireCompletionHandler = {_, _, json, error in
            if let error = error {
                failure(error)
                return
            }
            success()
            return
        }
        let query = "/\(self.id!)"
        Request().delete(path: .Entries, query: query, completionHandler: completionHandler)
    }
    
}