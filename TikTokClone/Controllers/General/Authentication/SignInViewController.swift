//
//  SignInViewController.swift
//  TikTokClone
//
//  Created by Alisher Djuraev on 14/06/22.
//

import SafariServices
import UIKit

class SignInViewController: UIViewController, UITextFieldDelegate {
    
    public var completion: (() -> Void)?
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        imageView.image = UIImage(named: "logo")
        return imageView
    }()
    
    private let emailField = AuthField(type: .email)
    private let passwordField = AuthField(type: .password)
    private let signInButton = AuthButton(type: .signIn, title: nil)
    private let forgotPassword = AuthButton(type: .plain, title: "Forgot Password")
    private let signUpButton = AuthButton(type: .plain, title: "New User? Create an Account")
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        title = "Sign In"
        embedSubviews()
        configureFields()
        configureButtons()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let imageSize: CGFloat = 100
        logoImageView.frame = CGRect(
            x: (view.width - imageSize) / 2,
            y: view.safeAreaInsets.top + 5,
            width: imageSize,
            height: imageSize
        )
        emailField.frame = CGRect(
            x: 20,
            y: logoImageView.bottom + 20,
            width: view.width - 40,
            height: 55
        )
        passwordField.frame = CGRect(
            x: 20,
            y: emailField.bottom + 15,
            width: view.width - 40,
            height: 55
        )
        signInButton.frame = CGRect(
            x: 20,
            y: passwordField.bottom + 20,
            width: view.width - 40,
            height: 55
        )
        forgotPassword.frame = CGRect(
            x: 20,
            y: signInButton.bottom + 40,
            width: view.width - 40,
            height: 55
        )
        signUpButton.frame = CGRect(
            x: 20,
            y: forgotPassword.bottom + 20,
            width: view.width - 40,
            height: 55
        )
    }
    
    fileprivate func configureFields() {
        emailField.delegate = self
        passwordField.delegate = self
        
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.width, height: 50))
        toolBar.items = [
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil),
            UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(didTapKeyboardDone))
        ]
        toolBar.sizeToFit()
        emailField.inputAccessoryView = toolBar
        passwordField.inputAccessoryView = toolBar
    }
    
    @objc private func didTapKeyboardDone() {
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
    }
    
    fileprivate func embedSubviews() {
        view.addSubview(logoImageView)
        view.addSubview(emailField)
        view.addSubview(passwordField)
        view.addSubview(signInButton)
        view.addSubview(signUpButton)
        view.addSubview(forgotPassword)
    }
    
    private func configureButtons() {
        signInButton.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)
        signUpButton.addTarget(self, action: #selector(didTapSignUp), for: .touchUpInside)
        forgotPassword.addTarget(self, action: #selector(didTapForgotPassword), for: .touchUpInside)
    }
    
    // Actions
    
    @objc private func didTapSignIn() {
        didTapKeyboardDone()
        
        guard let email = emailField.text,
              let password = passwordField.text,
              !email.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty,
              password.count >= 6 else {
            
            let alert = UIAlertController(title: "Woops", message: "Plese enter a valid email and password to sign in.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
            present(alert, animated: true)
                  return
        }
        AuthManager.shared.signIn(with: email, password: password) { loggedIn in
            if loggedIn {
                // dismiss sign in
                
            } else {
                // show error
                
            }
        }
    }
    
    @objc private func didTapSignUp() {
        didTapKeyboardDone()
        
        let vc = SignUpViewController()
        vc.title = "Create Account"
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func didTapForgotPassword() {
        guard let url = URL(string: "https://www.tiktok.com/forgot-password") else {
            return
        }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
}
