//
//  Alert.swift
//  HTTP_Networking_sample_ios_swift
//
//  Created by Kohei Hayakawa on 4/3/15.
//  Copyright (c) 2015 Kohei Hayakawa. All rights reserved.
//

import UIKit

typealias AlertActionHandler = (UIAlertAction! -> Void)

class Alerts {
    class func showEntryRemoveAlert(viewController: UIViewController, removeHandler: AlertActionHandler) {
        let alert = UIAlertController(
            title: "削除します",
            message: "本当によろしいですか？",
            preferredStyle: .Alert)
        alert.addAction(UIAlertAction(
            title: "削除する",
            style: .Default,
            handler: removeHandler))
        alert.addAction(UIAlertAction(title: "キャンセル", style: .Cancel, handler: nil))
        viewController.presentViewController(alert, animated: true, completion: nil)
    }
}
