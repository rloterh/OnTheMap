//
//  LoginVC.swift
//  OnTheMap
//
//  Created by Admin on 16/04/2020.
//  Copyright © 2020 com.robert.loterh. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
            self.emailTextField.becomeFirstResponder()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        emailTextField.text = ""
        passwordTextField.text = ""
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.hideKeyboardWhenTappedAround()
    }
    
    func handleLoginResponse(hasAccess: Bool, error: Error?){
        if hasAccess {
            performSegue(withIdentifier: "completeLogin", sender: nil)
            logIn(true)
        }else {
            showLoginFailure(message: error?.localizedDescription ?? "Wrong Email or Password!!")
            logIn(false)
        }
    }
    
    func showLoginFailure(message: String) {
        let alertVC = UIAlertController(title: "Login Failed", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        show(alertVC, sender: nil)
    }
    
    func logIn(_ login: Bool) {
        if login {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
    }
    
    @IBAction func loginPressed(_ sender: Any) {
        UdacityClient.login(with: emailTextField.text!, password: passwordTextField.text!, completion: handleLoginResponse(hasAccess:error:))
    }
    
    @IBAction func signUp(_ sender: Any) {
        UIApplication.shared.open(URL(string: "https://auth.udacity.com/sign-up")!, options: [:], completionHandler: nil)
    }
}
