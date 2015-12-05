//
//  User.swift
//  HTTP_Networking_sample_ios_swift
//
//  Created by Kohei Hayakawa on 4/10/15.
//  Copyright (c) 2015 Kohei Hayakawa. All rights reserved.
//

import UIKit
import ObjectMapper
import SwiftyJSON

class User: Common {
    
    var id: Int?
    var email: String?
    var accessToken: String?
    
    override func mapping(map: Map) {
        id    <- map["id"]
        email <- map["email"]
        accessToken <- map["access_token"]
    }
    
    class func signUp(email email: String, password: String, passwordConfirmation: String, success: User -> Void, failure: NSError? -> Void) {
        let completionHandler: AlamofireCompletionHandler = {response in
            
            // TODO: Json error handling
            if let error = response.result.error {
                failure(error)
                return
            }
            if let data: AnyObject = response.result.value {
                let json = JSON(data)
                let user = Mapper<User>().map(json.dictionaryObject!)!
                if let _ = user.accessToken {
                    success(user)
                    return
                }
            }
            failure(nil)
            return
        }
        let params: [String: AnyObject] = [
            "email" : email,
            "password" : password,
            "password_confirmation" : passwordConfirmation
        ]
        Request.post(path: .UserSignUp, params: params, completionHandler: completionHandler)
    }
    
    class func signIn(email email: String, password: String, success: User -> Void, failure: NSError? -> Void) {
        let completionHandler: AlamofireCompletionHandler = {response in
            
            // TODO: Json error handling
            if let error = response.result.error {
                failure(error)
                return
            }
            if let data: AnyObject = response.result.value {
                let json = JSON(data)
                let user = Mapper<User>().map(json.dictionaryObject!)!
                if let _ = user.accessToken {
                    success(user)
                    return
                }
            }
            failure(nil)
            return
        }
        let params: [String: AnyObject] = [
            "email" : email,
            "password" : password,
        ]
        Request.post(path: .UserSignIn, params: params, completionHandler: completionHandler)
    }
    
}