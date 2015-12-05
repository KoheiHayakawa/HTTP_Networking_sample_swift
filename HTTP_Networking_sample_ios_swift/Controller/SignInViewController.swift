//
//  SignInViewController.swift
//  HTTP_Networking_sample_ios_swift
//
//  Created by Kohei Hayakawa on 4/12/15.
//  Copyright (c) 2015 Kohei Hayakawa. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController, SignInViewDelegate {

    var signInView: SignInView?
    
    
    // MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        signInView = SignInView(frame: view.frame)
        signInView!.delegate = self
        view.addSubview(signInView!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: Sign in view delegate

    func signInView(signInView: SignInView, didTapSignInButton button: UIButton) {
        User.signIn(
            email: self.signInView!.emailTextField.text!,
            password: self.signInView!.passwordTextField.text!,
            success: {user in
                UserManager.signInByUser(user)
                let viewController = RootViewFactory.viewController()
                let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                appDelegate.changeRootViewController(viewController)
            },
            failure: {error in
                Alert.showSignInFailureAlert(self)
                print(error)
            }
        )
    }

    func signInView(signInView: SignInView, didTapSignUpButton button: UIButton) {
        let viewController = SignUpViewController()
        presentViewController(viewController, animated: true, completion: nil)
    }
}

