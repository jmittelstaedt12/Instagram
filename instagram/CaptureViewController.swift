//
//  CaptureViewController.swift
//  instagram
//
//  Created by Jacob Mittelstaedt on 3/9/17.
//  Copyright © 2017 Jacob Mittelstaedt. All rights reserved.
//

import UIKit
import MBProgressHUD

class CaptureViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {


    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var captureImageView: UIImageView!
    @IBOutlet weak var captionField: UITextField!
    @IBAction func onTap(_ sender: UITapGestureRecognizer) {
        let imagePicker = PhotoPick.createImagePicker()
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func onSave(_ sender: UIBarButtonItem) {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        Post.postUserImage(image: PhotoPick.resize(image: captureImageView.image!, newSize: CGSize(width:240,height:240)), withCaption: captionField.text) { (success: Bool, error: Error?) in
            if success {
                self.captureImageView.image = nil
                self.saveButton.isEnabled = false
                self.captionField.text = nil
                self.tabBarController?.selectedIndex = 0
                let navVC = self.tabBarController?.selectedViewController as! UINavigationController
                let homeVC = navVC.viewControllers.first as! HomeViewController
                homeVC.performQuery()
                homeVC.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: UITableViewScrollPosition(rawValue: 0)!, animated: false)
            } else{
                MBProgressHUD.hide(for: self.view, animated: true)
                print(error?.localizedDescription ?? "")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        captureImageView.image = image
        saveButton.isEnabled = true
        dismiss(animated: true, completion: nil)
    }

}
