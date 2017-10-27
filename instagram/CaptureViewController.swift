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
    @IBOutlet weak var createButton: UIButton!
    
    @IBAction func onCreate(_ sender: UIButton) {
        let imagePicker = PhotoPick.createImagePicker()
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    @IBAction func onSave(_ sender: UIBarButtonItem) {
        Post.postUserImage(image: PhotoPick.resize(image: captureImageView.image!, newSize: CGSize(width:240,height:240)), withCaption: captionField.text) { (success: Bool, error: Error?) in
            if success {
                print("post succeeded")
                let navVC = self.tabBarController?.viewControllers![0] as! UINavigationController
                let homeVC = navVC.viewControllers.first as! HomeViewController
                homeVC.performQuery()
                homeVC.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: UITableViewScrollPosition(rawValue: 0)!, animated: false)
                self.tabBarController?.selectedIndex = 0
                self.captureImageView.image = nil
                self.createButton.isHidden = false
                self.saveButton.isEnabled = false
                self.captionField.text = nil
            } else{
                print(error?.localizedDescription ?? "")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        captureImageView.image = image
        saveButton.isEnabled = true
        createButton.isHidden = true
        dismiss(animated: true, completion: nil)
    }

}
