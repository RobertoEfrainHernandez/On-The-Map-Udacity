//
//  LoginViewController.swift
//  On-The-Map-Udacity
//
//  Created by Roberto Hernandez on 1/21/18.
//  Copyright © 2018 Roberto Efrain Hernandez. All rights reserved.
//

import UIKit
import SafariServices

// Mark: -- Login View Controller
/***************************************************************/

class LoginViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate {
    
    // Mark: - OutLets
    /***************************************************************/
    @IBOutlet weak var udacityLogo: UIImageView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: BorderedButton!
    @IBOutlet weak var haveAccountLabel: UILabel!
    @IBOutlet weak var signUpButton: UIButton!
    
    // Mark: - Properties
    /***************************************************************/
    var activityIndicator = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.unsubscribeFromKeyboardNotifications()
    }
    

    
     // MARK: -- Navigation
     /***************************************************************/
    @IBAction func loginPressed(_ sender: Any) {
        
        
        showActivityIndicator(activityIndicator)
        
        if emailTextField.text!.isEmpty || passwordTextField.text!.isEmpty {
            displayAlert(title: "Login Unsuccessful", message: "Username and/or Password is empty")
        } else {
            UdacityClient.sharedInstance().authenticateUser(username: emailTextField.text!, password: passwordTextField.text!) { (success, errorString) in
                performUIUpdatesOnMain {
                    
                    self.hideActivityIndicator(self.activityIndicator)
                    
                    if success{
                        performUIUpdatesOnMain {
                            self.completeTheLogin()
                            print("Successfully logged in!")
                        }
                    } else if errorString != nil {
                        performUIUpdatesOnMain {
                            self.displayAlert(title: "Login Unsuccessful", message: errorString)
                        }
                    } else {
                        performUIUpdatesOnMain {
                            self.displayAlert(title: "Login Unsuccessful", message: "Invalid Username and/or Password")
                        }
                    }
                }
            }
        }
    }
    
    private func completeTheLogin() {
        
        /* Navigate to Map Tab Bar Controller*/
        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MapTabBar")
        self.present(controller, animated: true, completion: nil)
    }

    @IBAction func signUpPressed(_ sender: Any) {
        
        /* Open Udacity Sign Up URL */
        if let url = URL(string: "https://in.udacity.com/auth#signup") {
            let svc = SFSafariViewController(url: url)
            self.present(svc, animated: true, completion: nil)
        }
    }
    
    // MARK: -- TextField Helper
    /***************************************************************/
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    

}
