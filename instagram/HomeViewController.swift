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

    var postsArray = [PFObject]()
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), for: UIControlEvents.valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
        
        performQuery()
    }
    
    func performQuery(){
        let query = PFQuery(className: "Post")
        query.order(byDescending: "createdAt")
        query.whereKey("author", equalTo: PFUser.current())
        query.limit = 20
        query.findObjectsInBackground { (objects: [PFObject]?, error: Error?) -> Void in
            
            if let objects = objects{
                self.postsArray = objects
                self.tableView.reloadData()
                
                
            } else{
                print(error?.localizedDescription)
            }
        }
    }
    func refreshControlAction(_ refreshControl: UIRefreshControl){
        let query = PFQuery(className: "Post")
        query.order(byDescending: "createdAt")
        query.whereKey("author", equalTo: PFUser.current())
        query.limit = 20
        query.findObjectsInBackground { (objects: [PFObject]?, error: Error?) -> Void in
            
            if let objects = objects{
                self.postsArray = objects
                self.tableView.reloadData()
                refreshControl.endRefreshing()
            } else{
                print(error?.localizedDescription)
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as! HomeTableViewCell
        cell.postForCell = postsArray[indexPath.row]
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
        return postsArray.count
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
