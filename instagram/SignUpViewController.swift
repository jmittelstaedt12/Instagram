//
//  ViewController.swift
//  instagram
//
//  Created by Jacob Mittelstaedt on 10/26/17.
//  Copyright © 2017 Jacob Mittelstaedt. All rights reserved.
//

import UIKit
import Parse

class SignUpViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var usernameText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var bioText: UITextView!
    @IBOutlet weak var registerButton: UIButton!
    
    
    @IBAction func onImageTap(_ sender: UITapGestureRecognizer) {
        let imagePicker = PhotoPick.createImagePicker()
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
        registerButton.isEnabled = true
        
    }
    @IBAction func registerTap(_ sender: UIButton) {
        let newUser = PFUser()
        newUser.username = self.usernameText.text
        newUser.password = self.passwordText.text
        if profileImageView.image != nil{
            let imageFile = PFFile(data: UIImagePNGRepresentation(profileImageView.image!) as Data!)
            newUser.setObject(imageFile!, forKey: "profilePicture")
        }
        newUser.signUpInBackground { (success: Bool,error: Error?) in
            if success {
                print("succesfully created new user")
                self.dismiss(animated: true, completion: nil)
            }else{
                
                print(error?.localizedDescription)
            }
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        profileImageView.image = PhotoPick.resize(image: image, newSize: CGSize(width:119,height:119))
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
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
