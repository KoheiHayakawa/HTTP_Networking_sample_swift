//
//  UserManager.swift
//  HTTP_Networking_sample_ios_swift
//
//  Created by Kohei Hayakawa on 4/11/15.
//  Copyright (c) 2015 Kohei Hayakawa. All rights reserved.
//

import UIKit
import KeychainAccess

private let kServiceIdentifierKey = "com.koheihayakawa"
private let kAccessToken = "KHAAccessToken"
private let kIsSignInKey = "KHAIsSignIn"
private let kUserEmailKey = "KHAUserEmail"

class UserManager: NSObject {
    
    class var isSingIn: Bool {
        return NSUserDefaults.standardUserDefaults().boolForKey(kIsSignInKey)
    }
    
    class var email: String {
        if let email = NSUserDefaults.standardUserDefaults().objectForKey(kUserEmailKey) as? String {
            return email
        }
        return ""
    }
    
    class var accessToken: String {
        let keychain = Keychain(service: kServiceIdentifierKey)
        if let token = keychain[kAccessToken] {
            return token
        }
        return ""
    }

    class func signInByUser(user: User) {
        NSUserDefaults.standardUserDefaults().setBool(true, forKey: kIsSignInKey)
        NSUserDefaults.standardUserDefaults().setObject(user.email, forKey: kUserEmailKey)
        saveAccessToken(user.accessToken!)
    }

    class func signOut() {
        NSUserDefaults.standardUserDefaults().setBool(false, forKey: kIsSignInKey)
        let keychain = Keychain(service: kServiceIdentifierKey)
        removeAccessToken()
    }

    private class func saveAccessToken(accessToken: String) {
        let keychain = Keychain(service: kServiceIdentifierKey)
        keychain[kAccessToken] = accessToken
    }
    
    private class func removeAccessToken() {
        let keychain = Keychain(service: kServiceIdentifierKey)
        keychain[kAccessToken] = nil
    }

}