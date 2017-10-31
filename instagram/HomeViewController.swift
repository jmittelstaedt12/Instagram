//
//  HomeViewController.swift
//  instagram
//
//  Created by Jacob Mittelstaedt on 3/9/17.
//  Copyright © 2017 Jacob Mittelstaedt. All rights reserved.
//

import UIKit
import Parse
import MBProgressHUD

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    
    static var postsArray = [PFObject]()
    static var Image:UIImage? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), for: UIControlEvents.valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
        performQuery()
        
        if let image = (PFUser.current())?.value(forKey: "profilePicture") as? PFFile{
            image.getDataInBackground(block: { (imageData: Data?,error: Error?) in
                if error == nil{
                    HomeViewController.Image = UIImage(data: imageData!)
                }else{
                    print(error?.localizedDescription ?? "")
                }
            })
        }
    }
    
    func performQuery(){
        let query = PFQuery(className: "Post")
        query.order(byDescending: "createdAt")
        query.whereKey("author", equalTo: PFUser.current())
        query.limit = 20
        MBProgressHUD.showAdded(to: self.view, animated: true)
        query.findObjectsInBackground { (objects: [PFObject]?, error: Error?) -> Void in
            MBProgressHUD.hide(for: self.view, animated: true)
            if let objects = objects{
                HomeViewController.postsArray = objects
                self.tableView.reloadData()
            } else{
                print(error?.localizedDescription)
            }
        }
    }
    
    func refreshControlAction(_ refreshControl: UIRefreshControl){
        performQuery()
        refreshControl.endRefreshing()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as! HomeTableViewCell
        cell.postForCell = HomeViewController.postsArray[indexPath.row]
        if let postPFFile = cell.postForCell.value(forKey: "media") as? PFFile {
            postPFFile.getDataInBackground(block: { (imageData: Data?, error: Error?) -> Void in
                if error == nil {
                    
                    cell.postImageView.image = UIImage(data: imageData!)
                }
            })
        }
        cell.profileImageView.image = HomeViewController.Image
        cell.profileImageView.layer.cornerRadius = cell.profileImageView.frame.height/2
        cell.profileImageView.clipsToBounds = true
        cell.userLabel.text = PFUser.current()?.username
        cell.postCaptionLabel.text = cell.postForCell.value(forKey: "caption") as? String
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return HomeViewController.postsArray.count
    }

}
