//
//  LoginViewController.swift
//  TheMovieManager
//
//  Created by Owen LaRosa on 8/13/18.
//  Copyright © 2018 Udacity. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var pwdTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var loginViaWebsiteButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        emailTextField.text = "richard90_15@hotmail.com"
        pwdTextField.text = "123456789"
    }
    
    @IBAction func loginTapped(_ sender: UIButton) {
        setLoggingIn(true)
        ApiClient.getRequestToken(completion: handleRequestToken(success:error:))
    }
    
    @IBAction func loginViaWebsiteTapped() {
        setLoggingIn(true)
        ApiClient.getRequestToken { success, error in
            if success {
                UIApplication.shared.open(ApiClient.Endpoints.webAuth.url, options: [:], completionHandler: nil)
            }
        }
    }
    
    private func handleRequestToken(success: Bool, error: Error?) {
        if success {
            ApiClient.login(user: self.emailTextField.text ?? "", pwd: self.pwdTextField.text ?? "", completion: self.handleLogin(success:error:))
        } else {
            showLoginFailure(message: error?.localizedDescription ?? "")
        }
    }
    
    private func handleLogin(success: Bool, error: Error?) {
        if success {
            ApiClient.session(completion: handleSession(success:error:))
        } else {
            setLoggingIn(false)
            showLoginFailure(message: error?.localizedDescription ?? "")
        }
    }
    
    func handleSession(success: Bool, error: Error?) {
        setLoggingIn(false)
        if success {
            self.performSegue(withIdentifier: "completeLogin", sender: nil)
        } else {
            showLoginFailure(message: error?.localizedDescription ?? "")
        }
    }
    
    func setLoggingIn(_ loggingIn: Bool) {
        if loggingIn {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
        
        emailTextField.isEnabled = !loggingIn
        pwdTextField.isEnabled = !loggingIn
        loginButton.isEnabled = !loggingIn
        loginViaWebsiteButton.isEnabled = !loggingIn
    }
    
    private func showLoginFailure(message: String) {
        let alertController = UIAlertController(title: "Login Failure", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        show(alertController, sender: nil)
    }
    
}
