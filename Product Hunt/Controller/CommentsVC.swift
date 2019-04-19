//
//  PostsVC.swift
//  Product Hunt
//
//  Created by Vivek Rai on 18/04/19.
//  Copyright © 2019 Vivek Rai. All rights reserved.
//


import UIKit
import Alamofire
import SwiftyJSON
import SDWebImage
import SVProgressHUD
import AlamofireImage

class CommentsVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - Properties
    
    var commentsData = [CommentsModel]()
    
    @IBOutlet weak var commentsTableView: UITableView!
    var user_id: String?
    var post_id: String?
    var commentUrl = ""
    
    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commentsTableView.delegate = self
        commentsTableView.dataSource = self
        commentsTableView.rowHeight = 120
        commentsTableView.tableFooterView = UIView(frame: .zero)
        fetchComments()
        commentsTableView.reloadData()
        SVProgressHUD.show()
    }
    
    
    // MARK: - Networking
    
    func fetchComments(){
        commentUrl = "https://api.producthunt.com/v1/comments?search[post_id]=\(post_id!)&search[user_id]=\(user_id!)"
        let parameters: Parameters = ["access_token": accessToken]
        Alamofire.request(commentUrl, method : .get, parameters : parameters).responseJSON{
            response in
            if response.result.isSuccess{
                print("Success! Got the comments data")
                let postsJSON : JSON = JSON(response.result.value!)
                
                for i in 0..<postsJSON["comments"].count{
                    let comments = postsJSON["comments"][i]["body"].stringValue
                    let userId = postsJSON["comments"][i]["user_id"].stringValue
                    let votes = postsJSON["comments"][i]["votes"].intValue
                    let date = postsJSON["comments"][i]["created_at"].stringValue
                    let data = CommentsModel(comments: comments, userId: userId, votes: votes, date: date)
                    self.commentsData.append(data)
                    self.commentsTableView.reloadData()
                }
                SVProgressHUD.dismiss()
            }else{
                print("Error: \(String(describing: response.result.error))")
                SVProgressHUD.dismiss()
                return
            }
        }
        
    }
    
    
    // MARK: - UITableView
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commentsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CommentsCell
        let data = commentsData[indexPath.row]
        cell.dateLabel.text = data.date
        cell.votesLabel.text = String(data.votes)
        cell.commentLabel.text = "UserId: \(data.userId)  \(data.comments)"
        SVProgressHUD.dismiss()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
    }
    
    
    // MARK: - BackButton
    
    @IBAction func backButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    


}
