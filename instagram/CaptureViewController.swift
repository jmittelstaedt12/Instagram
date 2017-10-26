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
    @IBOutlet weak var captureImageView: UIImageView!
    @IBOutlet weak var captionField: UITextField!
    @IBAction func onSave(_ sender: UIBarButtonItem) {
        Post.postUserImage(image: resize(image: captureImageView.image!, newSize: CGSize(width:240,height:240)), withCaption: captionField.text) { (success: Bool, error: Error?) in
            if success {
                print("post succeeded")
                
            } else{
                print(error?.localizedDescription)
            }
        }
    }
    @IBAction func onCreate(_ sender: UIButton) {
        createImagePicker()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    
    func resize(image: UIImage, newSize: CGSize) -> UIImage {
        let resizeImageView = UIImageView(frame: CGRect(x:0, y:0, width:newSize.width, height:newSize.height))
        resizeImageView.contentMode = UIViewContentMode.scaleAspectFill
        resizeImageView.image = image
        
        UIGraphicsBeginImageContext(resizeImageView.frame.size)
        resizeImageView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
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
