//
//  LoginViewController.swift
//  instagram
//
//  Created by Jacob Mittelstaedt on 3/8/17.
//  Copyright © 2017 Jacob Mittelstaedt. All rights reserved.
//

import UIKit
import Parse
import MBProgressHUD

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBAction func signInButton(_ sender: UIButton) {
        PFUser.logOut()
        MBProgressHUD.showAdded(to: self.view, animated: true)
        PFUser.logInWithUsername(inBackground: usernameField.text!, password: passwordField.text!) { (user: PFUser?, error: Error?) in
            MBProgressHUD.hide(for: self.view, animated: true)
            if user != nil{
                print("successful login")
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            } else{
                let alert = UIAlertController(title: "Failed Login", message: error?.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func signUpButton(_ sender: UIButton) {
        PFUser.logOut()
        self.performSegue(withIdentifier: "signUpSegue", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        PFUser.logOut()
    }
}
