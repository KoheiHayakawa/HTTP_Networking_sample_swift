//
//  Alert.swift
//  HTTP_Networking_sample_ios_swift
//
//  Created by Kohei Hayakawa on 4/3/15.
//  Copyright (c) 2015 Kohei Hayakawa. All rights reserved.
//

import UIKit

typealias AlertActionHandler = (UIAlertAction! -> Void)

class Alert {
    class func showEntryRemoveAlert(viewController: UIViewController, removeHandler: AlertActionHandler) {
        let alert = UIAlertController(
            title: "Detele entry",
            message: "Are you sure?",
            preferredStyle: .Alert)
        alert.addAction(UIAlertAction(
            title: "OK",
            style: .Default,
            handler: removeHandler))
        alert.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        viewController.presentViewController(alert, animated: true, completion: nil)
    }
    
    class func showSignInFailureAlert(viewController: UIViewController) {
        let alert = UIAlertController(
            title: "Failed to sign in",
            message: "Confirm you email or password",
            preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
        viewController.presentViewController(alert, animated: true, completion: nil)
    }
    
    class func showSignUpFailureAlert(viewController: UIViewController) {
        let alert = UIAlertController(
            title: "Failed to sign up",
            message: "Confirm you email or password",
            preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
        viewController.presentViewController(alert, animated: true, completion: nil)
    }
    
    class func showNoInternetConnectionAvailableAlertWithTitle(title: String, target: UIViewController) {
        let alertController = UIAlertController(
            title: title,
            message: "No internet connection available.",
            preferredStyle: .Alert)
        alertController.addAction(UIAlertAction(
            title: "OK",
            style: .Default,
            handler: nil))
        target.presentViewController(alertController, animated: true, completion: nil)
    }
}
