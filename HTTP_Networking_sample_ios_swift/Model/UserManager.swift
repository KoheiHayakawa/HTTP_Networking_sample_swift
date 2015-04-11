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
private let kIsLoginingKey = "KHAIsLogining"

class UserManager: NSObject {
    
    class var isSingIn: Bool {
        return NSUserDefaults.standardUserDefaults().boolForKey(kIsLoginingKey)
    }
    
    class var accessToken: String {
        let keychain = Keychain(service: kServiceIdentifierKey)
        return keychain[kAccessToken]!
    }

    class func signInWithAccessToken(accessToken: String) {
        NSUserDefaults.standardUserDefaults().setBool(true, forKey: kIsLoginingKey)
        saveAccessToken(accessToken)
    }

    class func signOut() {
        NSUserDefaults.standardUserDefaults().setBool(false, forKey: kIsLoginingKey)
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