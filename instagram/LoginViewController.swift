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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        PFUser.logOut()
        // Do any additional setup after loading the view.
    }
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
        let newUser = PFUser()
        newUser.username = usernameField.text
        newUser.password = passwordField.text
        newUser.signUpInBackground { (success: Bool,error: Error?) in
            if success {
                print("succesfully created new user")
                self.performSegue(withIdentifier: "loginSegue", sender: nil)

            }else{
               print(error?.localizedDescription)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
