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

    func signInView(signInView: SignInView, didTapSignInButton button: UIButton) {
        User.signIn(
            email: signInView.emailTextField.text,
            password: signInView.passwordTextField.text,
            success: {user in
                UserManager.signInWithAccessToken(user.accessToken!)
                let viewController = FirstViewFactory.viewController()
                let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                appDelegate.changeRootViewController(viewController)
            },
            failure: {error in
                Alerts.showSignInFailureAlert(self)
                println(error)
            }
        )
        
        //        User.signUp(
        //            email: "hhh@aaa.com",
        //            password: "aaaa",
        //            passwordConfirmation: "aaaa",
        //            success: {user in println(user)},
        //            failure: {error in println(error)})
    }

    func signInView(signInView: SignInView, didTapSignUpButton button: UIButton) {
        println("sign up")
        
        //        User.signUp(
        //            email: "hhh@aaa.com",
        //            password: "aaaa",
        //            passwordConfirmation: "aaaa",
        //            success: {user in println(user)},
        //            failure: {error in println(error)})
    }
}

