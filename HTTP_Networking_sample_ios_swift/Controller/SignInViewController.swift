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
        println(signInView.emailTextField.text)
        println(signInView.passwordTextField.text)
    }

}
