//
//  HomeViewController.swift
//  instagram
//
//  Created by Jacob Mittelstaedt on 3/9/17.
//  Copyright © 2017 Jacob Mittelstaedt. All rights reserved.
//

import UIKit
import Parse

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    static var postsArray = [PFObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), for: UIControlEvents.valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
        performQuery()
        let navVC = self.tabBarController?.viewControllers![2] as! UINavigationController
        let homeVC = navVC.viewControllers.first as! ProfileViewController
        //homeVC.userPostsArray = postsArray
    }
    
    func performQuery(){
        let query = PFQuery(className: "Post")
        query.order(byDescending: "createdAt")
        query.whereKey("author", equalTo: PFUser.current())
        query.limit = 20
        query.findObjectsInBackground { (objects: [PFObject]?, error: Error?) -> Void in
            
            if let objects = objects{
                HomeViewController.postsArray = objects
                self.tableView.reloadData()
//                let navVC = self.tabBarController?.viewControllers![2] as! UINavigationController
//                let profileVC = navVC.viewControllers.first as! ProfileViewController
//                profileVC.collectionView.reloadData()
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
        cell.postCaptionLabel.text = cell.postForCell.value(forKey: "caption") as? String
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return HomeViewController.postsArray.count
    }

}
