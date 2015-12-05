//
//  Request.swift
//  HTTP_Networking_sample_ios_swift
//
//  Created by Kohei Hayakawa on 3/8/15.
//  Copyright (c) 2015 Kohei Hayakawa. All rights reserved.
//

import UIKit
import Alamofire

//typealias AlamofireCompletionHandler = ((NSURLRequest, NSHTTPURLResponse?, AnyObject?, NSError?) -> Void)
typealias AlamofireCompletionHandler = (Response<AnyObject, NSError> -> Void)

enum Path : String {
    case Entries = "/entries"
    case UserSignUp = "/users/sign_up"
    case UserSignIn = "/users/sign_in"
}

class Request {
    
    private class var kBaseURL: String {
        return "http://localhost:3000/api/v1"
    }
    
    private class func prepareRequestWithoutAuth(method method: Alamofire.Method, URL: NSURL) -> NSMutableURLRequest {
        let request = NSMutableURLRequest(URL: URL)
        request.HTTPMethod = method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        return request
    }
    
    private class func prepareRequest(method method:Alamofire.Method, URL: NSURL) -> NSURLRequest {
        let request = prepareRequestWithoutAuth(method: method, URL: URL)
        let accessToken = UserManager.accessToken
        request.setValue("Token token=\"\(accessToken)\"", forHTTPHeaderField: "Authorization")
        return request
    }
    
    class func get(path path: Path, completionHandler: AlamofireCompletionHandler) {
        let urlStr = kBaseURL + path.rawValue
        if let URL = NSURL(string: urlStr) {
            let request = prepareRequest(method: .GET, URL: URL)
            Alamofire.request(request).responseJSON(options: [], completionHandler: completionHandler)
        }
    }
    
    class func get(path path: Path, query: String, completionHandler: AlamofireCompletionHandler) {
        if let encodedQuery = query.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet()){
            let urlStr = kBaseURL + path.rawValue + encodedQuery
            if let URL = NSURL(string: urlStr) {
                let request = prepareRequest(method: .GET, URL: URL)
                Alamofire.request(request).responseJSON(options: [], completionHandler: completionHandler)
            }
        }
    }
    
    class func post(path path: Path, params: [String: AnyObject]?, completionHandler:AlamofireCompletionHandler) {
        let urlStr = kBaseURL + path.rawValue
        if let URL = NSURL(string: urlStr) {
            if let params = params {
                var request = prepareRequest(method: .POST, URL: URL)
                request = Alamofire.ParameterEncoding.JSON.encode(request, parameters: params).0 
                Alamofire.request(request).responseJSON(options: [], completionHandler: completionHandler)
            }
        }
    }
    
    class func update(path path: Path, query: String, params: [String: AnyObject]?, completionHandler: AlamofireCompletionHandler) {
        if let encodedQuery = query.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet()) {
            let urlStr = kBaseURL + path.rawValue + encodedQuery
            if let URL = NSURL(string: urlStr) {
                if let params = params {
                    var request = prepareRequest(method: .PATCH, URL: URL)
                    request = Alamofire.ParameterEncoding.JSON.encode(request, parameters: params).0
                    Alamofire.request(request).responseJSON(options: [], completionHandler: completionHandler)
                }
            }
        }
    }
    
    class func delete(path path: Path, query: String, completionHandler: AlamofireCompletionHandler) {
        if let encodedQuery = query.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet()){
            let urlStr = kBaseURL + path.rawValue + encodedQuery
            if let URL = NSURL(string: urlStr) {
                let request = prepareRequest(method: .DELETE, URL: URL)
                Alamofire.request(request).responseJSON(options: [], completionHandler: completionHandler)
            }
        }
    }
    
}