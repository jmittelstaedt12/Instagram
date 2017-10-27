//
//  ProfileViewController.swift
//  instagram
//
//  Created by Jacob Mittelstaedt on 3/9/17.
//  Copyright © 2017 Jacob Mittelstaedt. All rights reserved.
//

import UIKit
import Parse
class ProfileViewController: UIViewController {

    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var bioLabel: UILabel!
    
    @IBAction func onLogout(_ sender: UIButton) {
        PFUser.logOut()
        dismiss(animated: true, completion: nil)
        performSegue(withIdentifier: "logoutSegue", sender: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let user = PFUser.current()
        nameLabel.text = user?.username
        if let userPicture = user?.value(forKey: "profilePicture") as? PFFile{
            userPicture.getDataInBackground(block: { (imageData: Data?,error: Error?) in
                if error == nil{
                    self.profileImageView.image = UIImage(data: imageData!)
                }else{
                    print(error?.localizedDescription ?? "")
                }
            })
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
