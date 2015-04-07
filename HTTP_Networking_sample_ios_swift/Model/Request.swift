//
//  Request.swift
//  HTTP_Networking_sample_ios_swift
//
//  Created by Kohei Hayakawa on 3/8/15.
//  Copyright (c) 2015 Kohei Hayakawa. All rights reserved.
//

import UIKit
import Alamofire

typealias AlamofireCompletionHandler = ((NSURLRequest, NSHTTPURLResponse?, AnyObject?, NSError?) -> Void)

enum Path : String {
    case Entries = "/entries"
}

class Request {
    
    private class var kBaseURL: String {
        return "http://localhost:3000"
    }
    
    private class func prepareRequestWithoutAuth(#method: Alamofire.Method, URL: NSURL) -> NSMutableURLRequest {
        let request = NSMutableURLRequest(URL: URL)
        request.HTTPMethod = method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        return request
    }
    
    private class func prepareRequest(#method:Alamofire.Method, URL: NSURL) -> NSURLRequest {
        var request = prepareRequestWithoutAuth(method: method, URL: URL)
        
        // auth
        //request.setValue("authenticity_token=\"\(token)\"", forHTTPHeaderField: "Authorization")
        
        return request
    }
    
    class func get(#path: Path, completionHandler: AlamofireCompletionHandler) {
        let urlStr = kBaseURL + path.rawValue
        if let URL = NSURL(string: urlStr) {
            let request = prepareRequest(method: .GET, URL: URL)
            Alamofire.request(request).responseJSON(completionHandler)
        }
    }
    
    class func get(#path: Path, query: String, completionHandler: AlamofireCompletionHandler) {
        if let encodedQuery = query.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet()){
            let urlStr = kBaseURL + path.rawValue + encodedQuery
            if let URL = NSURL(string: urlStr) {
                let request = prepareRequest(method: .GET, URL: URL)
                Alamofire.request(request).responseJSON(completionHandler)
            }
        }
    }
    
    class func post(#path: Path, params: [String: AnyObject]?, completionHandler:AlamofireCompletionHandler) {
        let urlStr = kBaseURL + path.rawValue
        if let URL = NSURL(string: urlStr) {
            if let params = params {
                var request = prepareRequest(method: .POST, URL: URL)
                request = Alamofire.ParameterEncoding.JSON.encode(request, parameters: params).0 as NSMutableURLRequest
                Alamofire.request(request).responseJSON(completionHandler)
                //Alamofire.request(.POST, urlStr, parameters: params, encoding: .JSON).responseJSON(handler)
            }
        }
    }
    
    class func update(#path: Path, query: String, params: [String: AnyObject]?, completionHandler: AlamofireCompletionHandler) {
        if let encodedQuery = query.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet()) {
            let urlStr = kBaseURL + path.rawValue + encodedQuery
            if let URL = NSURL(string: urlStr) {
                if let params = params {
                    var request = prepareRequest(method: .PATCH, URL: URL)
                    request = Alamofire.ParameterEncoding.JSON.encode(request, parameters: params).0 as NSMutableURLRequest
                    Alamofire.request(request).responseJSON(completionHandler)
                }
            }
        }
    }
    
    class func delete(#path: Path, query: String, completionHandler: AlamofireCompletionHandler) {
        if let encodedQuery = query.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet()){
            let urlStr = kBaseURL + path.rawValue + encodedQuery
            if let URL = NSURL(string: urlStr) {
                let request = prepareRequest(method: .DELETE, URL: URL)
                Alamofire.request(request).responseJSON(completionHandler)
            }
        }
    }
    
}