//
//  SignInView.swift
//  HTTP_Networking_sample_ios_swift
//
//  Created by Kohei Hayakawa on 4/12/15.
//  Copyright (c) 2015 Kohei Hayakawa. All rights reserved.
//

import UIKit

protocol SignInViewDelegate: class {
    func signInView(signInView: SignInView, didTapSignInButton button: UIButton)
}

class SignInView: UIView {

    let emailTextField = UITextField()
    let passwordTextField = UITextField()
    private let signInButton = UIButton()
    
    weak var delegate: SignInViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.whiteColor()
        
        emailTextField.borderStyle = .RoundedRect
        emailTextField.placeholder = "Email"
        emailTextField.keyboardType = .EmailAddress
        emailTextField.clearButtonMode = UITextFieldViewMode.Always
        emailTextField.setTranslatesAutoresizingMaskIntoConstraints(false)
        addSubview(emailTextField)
        addConstraints([
            NSLayoutConstraint(
                item: emailTextField,
                attribute: .Left,
                relatedBy: .Equal,
                toItem: self,
                attribute: .Left,
                multiplier: 1,
                constant: 10),
            NSLayoutConstraint(
                item: emailTextField,
                attribute: .Right,
                relatedBy: .Equal,
                toItem: self,
                attribute: .Right,
                multiplier: 1,
                constant: -10),
            NSLayoutConstraint(
                item: emailTextField,
                attribute: .Top,
                relatedBy: .Equal,
                toItem: self,
                attribute: .Top,
                multiplier: 1,
                constant: 200),
            NSLayoutConstraint(
                item: emailTextField,
                attribute: .Height,
                relatedBy: .Equal,
                toItem: nil,
                attribute: .NotAnAttribute,
                multiplier: 1,
                constant: 44)]
        )
        
        passwordTextField.borderStyle = UITextBorderStyle.RoundedRect
        passwordTextField.placeholder = "Password"
        passwordTextField.clearButtonMode = UITextFieldViewMode.Always
        passwordTextField.secureTextEntry = true
        passwordTextField.setTranslatesAutoresizingMaskIntoConstraints(false)
        addSubview(passwordTextField)
        addConstraints([
            NSLayoutConstraint(
                item: passwordTextField,
                attribute: .Left,
                relatedBy: .Equal,
                toItem: self,
                attribute: .Left,
                multiplier: 1,
                constant: 10),
            NSLayoutConstraint(
                item: passwordTextField,
                attribute: .Right,
                relatedBy: .Equal,
                toItem: self,
                attribute: .Right,
                multiplier: 1,
                constant: -10),
            NSLayoutConstraint(
                item: passwordTextField,
                attribute: .Height,
                relatedBy: .Equal,
                toItem: nil,
                attribute: .NotAnAttribute,
                multiplier: 1,
                constant: 44),
            NSLayoutConstraint(
                item: passwordTextField,
                attribute: .Top,
                relatedBy: .Equal,
                toItem: emailTextField,
                attribute: .Top,
                multiplier: 1,
                constant: 54)]
        )
        
        signInButton.backgroundColor = UIColor.lightGrayColor()
        signInButton.setTitle("Sign in", forState: .Normal)
        signInButton.addTarget(self, action: "didTapSignInButton:", forControlEvents: .TouchUpInside)
        signInButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        addSubview(signInButton)
        addConstraints([
            NSLayoutConstraint(
                item: signInButton,
                attribute: .Left,
                relatedBy: .Equal,
                toItem: self,
                attribute: .Left,
                multiplier: 1,
                constant: 10),
            NSLayoutConstraint(
                item: signInButton,
                attribute: .Right,
                relatedBy: .Equal,
                toItem: self,
                attribute: .Right,
                multiplier: 1,
                constant: -10),
            NSLayoutConstraint(
                item: signInButton,
                attribute: .Height,
                relatedBy: .Equal,
                toItem: nil,
                attribute: .NotAnAttribute,
                multiplier: 1,
                constant: 44),
            NSLayoutConstraint(
                item: signInButton,
                attribute: .Top,
                relatedBy: .Equal,
                toItem: passwordTextField,
                attribute: .Top,
                multiplier: 1,
                constant: 54)]
        )

    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func didTapSignInButton(sender: UIButton) {
        delegate?.signInView(self, didTapSignInButton: sender)
    }

}
