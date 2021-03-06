//
//  SignUpView.swift
//  HTTP_Networking_sample_ios_swift
//
//  Created by Kohei Hayakawa on 4/12/15.
//  Copyright (c) 2015 Kohei Hayakawa. All rights reserved.
//

import UIKit

protocol SignUpViewDelegate: class {
    func signUpView(signInView: SignUpView, didTapSignUpButton button: UIButton)
    func signUpView(signInView: SignUpView, didTapCancelButton button: UIButton)
}

class SignUpView: UIView {
    
    let emailTextField = UITextField()
    let passwordTextField = UITextField()
    let passwordConfirmationTextField = UITextField()
    private let signUpButton = UIButton()
    private let cancelButton = UIButton()
    
    weak var delegate: SignUpViewDelegate? // delegate must be weak to prevent circular reference
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.whiteColor()
        
        emailTextField.borderStyle = .RoundedRect
        emailTextField.placeholder = "Email"
        emailTextField.keyboardType = .EmailAddress
        emailTextField.returnKeyType = .Next
        emailTextField.clearButtonMode = UITextFieldViewMode.Always
        emailTextField.addTarget(self, action: "emailTextFieldEditingDidEndOnExit:", forControlEvents: UIControlEvents.EditingDidEndOnExit)
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
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
        passwordTextField.returnKeyType = .Next
        passwordTextField.clearButtonMode = UITextFieldViewMode.Always
        passwordTextField.secureTextEntry = true
        passwordTextField.addTarget(self, action: "passwordTextFieldEditingDidEndOnExit:", forControlEvents: UIControlEvents.EditingDidEndOnExit)
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
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
        
        passwordConfirmationTextField.borderStyle = UITextBorderStyle.RoundedRect
        passwordConfirmationTextField.placeholder = "Password Confirmation"
        passwordConfirmationTextField.returnKeyType = .Go
        passwordConfirmationTextField.clearButtonMode = UITextFieldViewMode.Always
        passwordConfirmationTextField.secureTextEntry = true
        passwordConfirmationTextField.addTarget(self, action: "passwordConfirmationTextFieldEditingDidEndOnExit:", forControlEvents: UIControlEvents.EditingDidEndOnExit)
        passwordConfirmationTextField.translatesAutoresizingMaskIntoConstraints = false
        addSubview(passwordConfirmationTextField)
        addConstraints([
            NSLayoutConstraint(
                item: passwordConfirmationTextField,
                attribute: .Left,
                relatedBy: .Equal,
                toItem: self,
                attribute: .Left,
                multiplier: 1,
                constant: 10),
            NSLayoutConstraint(
                item: passwordConfirmationTextField,
                attribute: .Right,
                relatedBy: .Equal,
                toItem: self,
                attribute: .Right,
                multiplier: 1,
                constant: -10),
            NSLayoutConstraint(
                item: passwordConfirmationTextField,
                attribute: .Height,
                relatedBy: .Equal,
                toItem: nil,
                attribute: .NotAnAttribute,
                multiplier: 1,
                constant: 44),
            NSLayoutConstraint(
                item: passwordConfirmationTextField,
                attribute: .Top,
                relatedBy: .Equal,
                toItem: passwordTextField,
                attribute: .Top,
                multiplier: 1,
                constant: 54)]
        )
        
        signUpButton.backgroundColor = UIColor.lightGrayColor()
        signUpButton.setTitle("Sign up", forState: .Normal)
        signUpButton.addTarget(self, action: "didTapSignUpButton:", forControlEvents: .TouchUpInside)
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(signUpButton)
        addConstraints([
            NSLayoutConstraint(
                item: signUpButton,
                attribute: .Left,
                relatedBy: .Equal,
                toItem: self,
                attribute: .Left,
                multiplier: 1,
                constant: 10),
            NSLayoutConstraint(
                item: signUpButton,
                attribute: .Right,
                relatedBy: .Equal,
                toItem: self,
                attribute: .Right,
                multiplier: 1,
                constant: -10),
            NSLayoutConstraint(
                item: signUpButton,
                attribute: .Height,
                relatedBy: .Equal,
                toItem: nil,
                attribute: .NotAnAttribute,
                multiplier: 1,
                constant: 44),
            NSLayoutConstraint(
                item: signUpButton,
                attribute: .Top,
                relatedBy: .Equal,
                toItem: passwordConfirmationTextField,
                attribute: .Top,
                multiplier: 1,
                constant: 54)]
        )
        
        cancelButton.backgroundColor = UIColor.lightGrayColor()
        cancelButton.setTitle("Cancel", forState: .Normal)
        cancelButton.addTarget(self, action: "didTapCancelButton:", forControlEvents: .TouchUpInside)
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(cancelButton)
        addConstraints([
            NSLayoutConstraint(
                item: cancelButton,
                attribute: .Left,
                relatedBy: .Equal,
                toItem: self,
                attribute: .Left,
                multiplier: 1,
                constant: 10),
            NSLayoutConstraint(
                item: cancelButton,
                attribute: .Right,
                relatedBy: .Equal,
                toItem: self,
                attribute: .Right,
                multiplier: 1,
                constant: -10),
            NSLayoutConstraint(
                item: cancelButton,
                attribute: .Height,
                relatedBy: .Equal,
                toItem: nil,
                attribute: .NotAnAttribute,
                multiplier: 1,
                constant: 44),
            NSLayoutConstraint(
                item: cancelButton,
                attribute: .Bottom,
                relatedBy: .Equal,
                toItem: self,
                attribute: .Bottom,
                multiplier: 1,
                constant: -50)]
        )
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func emailTextFieldEditingDidEndOnExit(sender: UITextField) {
        passwordTextField.becomeFirstResponder()
    }
    
    func passwordTextFieldEditingDidEndOnExit(sender: UITextField) {
        passwordConfirmationTextField.becomeFirstResponder()
    }
    
    func passwordConfirmationTextFieldEditingDidEndOnExit(sender: UITextField) {
        didTapSignUpButton(signUpButton)
    }
    
    func didTapSignUpButton(sender: UIButton) {
        delegate?.signUpView(self, didTapSignUpButton: sender)
    }
    
    func didTapCancelButton(sender: UIButton) {
        delegate?.signUpView(self, didTapCancelButton: sender)
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        endEditing(true)
    }

}
