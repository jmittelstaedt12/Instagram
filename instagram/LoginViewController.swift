//
//  LoginViewController.swift
//  instagram
//
//  Created by Jacob Mittelstaedt on 3/8/17.
//  Copyright © 2017 Jacob Mittelstaedt. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBAction func signInButton(_ sender: UIButton) {
        PFUser.logOut()
        PFUser.logInWithUsername(inBackground: usernameField.text!, password: passwordField.text!) { (user: PFUser?, error: Error?) in
            if user != nil{
                print("successful login")
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            } else{
                print(error?.localizedDescription)
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
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if(segue.identifier == "loginSegue") {
//            let user = PFUser.current()
//            let navVC = segue.destination as? UITabBarController
//            let detailedVC = navVC?.viewControllers?.first as! ProfileViewController
//            detailedVC.nameLabel.text = user?.username
//        }
//    }
}
