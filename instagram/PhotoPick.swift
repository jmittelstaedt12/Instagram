//
//  PhotoPick.swift
//  instagram
//
//  Created by Jacob Mittelstaedt on 10/27/17.
//  Copyright © 2017 Jacob Mittelstaedt. All rights reserved.
//
import UIKit
import Foundation

class PhotoPick{

    static func createImagePicker() -> UIImagePickerController{
        let imagePicker = UIImagePickerController()
        
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            imagePicker.sourceType = .camera
        }else{
            imagePicker.sourceType = .photoLibrary
        }
        return imagePicker
    }

    static func resize(image: UIImage, newSize: CGSize) -> UIImage {
        let resizeImageView = UIImageView(frame: CGRect(x:0, y:0, width:newSize.width, height:newSize.height))
        resizeImageView.contentMode = UIViewContentMode.scaleAspectFill
        resizeImageView.image = image
        
        UIGraphicsBeginImageContext(resizeImageView.frame.size)
        resizeImageView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
}
