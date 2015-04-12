//
//  SignUpViewController.swift
//  HTTP_Networking_sample_ios_swift
//
//  Created by Kohei Hayakawa on 4/12/15.
//  Copyright (c) 2015 Kohei Hayakawa. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController, SignUpViewDelegate {

    var signUpView: SignUpView?
    
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        signUpView = SignUpView(frame: view.frame)
        signUpView!.delegate = self
        view.addSubview(signUpView!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // MARK: Sign up view delegate
    
    func signUpView(signUpView: SignUpView, didTapSignUpButton button: UIButton) {
        User.signUp(
            email: self.signUpView!.emailTextField.text,
            password: self.signUpView!.passwordTextField.text,
            passwordConfirmation: self.signUpView!.passwordConfirmationTextField.text,
            success: {user in
                UserManager.signInByUser(user)
                let viewController = RootViewFactory.viewController()
                let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                appDelegate.changeRootViewController(viewController)
            },
            failure: {error in
                Alert.showSignUpFailureAlert(self)
                println(error)
            }
        )
    }
    
    func signUpView(signUpView: SignUpView, didTapCancelButton button: UIButton) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
