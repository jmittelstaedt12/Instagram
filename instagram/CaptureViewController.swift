//
//  CaptureViewController.swift
//  instagram
//
//  Created by Jacob Mittelstaedt on 3/9/17.
//  Copyright © 2017 Jacob Mittelstaedt. All rights reserved.
//

import UIKit

class CaptureViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    @IBAction func onSave(_ sender: UIBarButtonItem) {
        Post.postUserImage(image: captureImageView.image, withCaption: captionField.text) { (success: Bool, error: Error?) in
            if success {
                print("post succeeded")
                
            } else{
                print(error?.localizedDescription)
            }
        }
    }
    @IBOutlet weak var captionField: UITextField!
    @IBAction func onCreate(_ sender: UIButton) {
        createImagePicker()
        
    }
    @IBOutlet weak var captureImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createImagePicker(){
        let imagePicker = UIImagePickerController()
        
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            imagePicker.sourceType = .camera
        }else{
            imagePicker.sourceType = .photoLibrary
        }
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        captureImageView.image = image
        saveButton.isEnabled = true
        dismiss(animated: true, completion: nil)
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
