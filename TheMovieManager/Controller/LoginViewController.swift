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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        emailTextField.text = "richard90_15@hotmail.com"
        pwdTextField.text = "123456789"
    }
    
    @IBAction func loginTapped(_ sender: UIButton) {
        ApiClient.getRequestToken(completion: handleRequestToken(success:error:))
//        performSegue(withIdentifier: "completeLogin", sender: nil)
        
        
    }
    
    @IBAction func loginViaWebsiteTapped() {
        performSegue(withIdentifier: "completeLogin", sender: nil)
    }
    
    private func handleRequestToken(success: Bool, error: Error?) {
        if success {
            print(ApiClient.Auth.requestToken)
            
            DispatchQueue.main.async {
                ApiClient.login(user: self.emailTextField.text ?? "", pwd: self.pwdTextField.text ?? "", completion: self.handleLogin(success:error:))
            }
        }
    }
    
    private func handleLogin(success: Bool, error: Error?) {
        if success {
            print(ApiClient.Auth.requestToken)
            ApiClient.session(completion: handleSession(success:error:))
        } else {
            print("error")
        }
        
    }
    
    private func handleSession(success: Bool, error: Error?) {
        print(ApiClient.Auth.sessionId)
    }
    
}
