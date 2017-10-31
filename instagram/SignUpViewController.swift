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
    @IBOutlet weak var photoLabel: UILabel!
    
    
    @IBAction func onCancel(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func onImageTap(_ sender: UITapGestureRecognizer) {
        let imagePicker = PhotoPick.createImagePicker()
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
        
    }
    @IBAction func registerTap(_ sender: UIButton) {
        let newUser = PFUser()
        newUser.username = self.usernameText.text
        newUser.password = self.passwordText.text
        newUser.setObject(bioText.text, forKey: "bio")
        if profileImageView.image != nil{
            let imageFile = PFFile(data: UIImagePNGRepresentation(profileImageView.image!) as Data!)
            newUser.setObject(imageFile!, forKey: "profilePicture")
        }
        newUser.signUpInBackground { (success: Bool,error: Error?) in
            if success {
                print("succesfully created new user")
                PFUser.logOut()
                self.dismiss(animated: true, completion: nil)
            }else{
                print(error?.localizedDescription)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileImageView.layer.cornerRadius = profileImageView.frame.height/2
        profileImageView.clipsToBounds = true
        photoLabel.layer.cornerRadius = photoLabel.frame.height/2
        photoLabel.clipsToBounds = true
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        profileImageView.image = PhotoPick.resize(image: image, newSize: CGSize(width:119,height:119))
        registerButton.isEnabled = true
        dismiss(animated: true, completion: nil)
    }

}
