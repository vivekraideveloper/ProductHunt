//
//  ViewController.swift
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


class PostsVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
   
    // MARK: - Properties
    
    var postsData = [PostsDataModel]()
    var filteredPostData = [PostsDataModel]()
    var inSearchMode = false

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var postTableView: UITableView!
    
    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        postTableView.delegate = self
        postTableView.dataSource = self
        postTableView.tableFooterView = UIView(frame: .zero)
        postTableView.rowHeight = 350
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.done
        fetchPosts(url: baseURL)
        postTableView.reloadData()
    }
    
    // MARK: - Networking
    
    func fetchPosts(url: String){
        SVProgressHUD.show()
        let parameters: Parameters = ["access_token": accessToken]
        Alamofire.request(url, method : .get, parameters : parameters).responseJSON{
            response in
            if response.result.isSuccess{
                print("Success! Got the posts data")
                let postsJSON : JSON = JSON(response.result.value!)
                
                for i in 0..<postsJSON["posts"].count{
                    let name = postsJSON["posts"][i]["name"].stringValue
                    let tagLine = postsJSON["posts"][i]["tagline"].stringValue
                    let commentCount = postsJSON["posts"][i]["comments_count"].intValue
                    let imageUrl = postsJSON["posts"][i]["thumbnail"]["image_url"].stringValue
                    let postId = postsJSON["posts"][i]["id"].stringValue
                    let userId = postsJSON["posts"][i]["user"]["id"].stringValue
                    let data = PostsDataModel(name: name, tagLine: tagLine, commentCount: commentCount, imageUrl: imageUrl, userId: userId, postId: postId)
                    self.postsData.append(data)
                    self.postTableView.reloadData()
                    SVProgressHUD.dismiss()
                }
            }else{
                print("Error: \(String(describing: response.result.error))")
                SVProgressHUD.dismiss()
                return
            }
        }
    }
    
    
    // MARK: - UITableView
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if inSearchMode{
            return filteredPostData.count
        }
        return postsData.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PostsCell
        var data = postsData[indexPath.row]
        if inSearchMode{
            data = filteredPostData[indexPath.row]
        }
        
        cell.nameLabel.text = data.name
        cell.tagLineLabel.text = data.tagLine
        cell.commentCountLabel.text = String(data.commentCount)
        cell.downloadImage(withUrlString: data.imageUrl)
        

        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "comments", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "comments"{
            let destinationVC = segue.destination as! CommentsVC
            var data = postsData[(postTableView.indexPathForSelectedRow?.row)!]
            if inSearchMode{
                data = filteredPostData[(postTableView.indexPathForSelectedRow?.row)!]
            }
            destinationVC.user_id = data.userId
            destinationVC.post_id = data.postId
        }
    }
    
    // MARK: - FilterButton
    
    @IBAction func filterButtonPressed(_ sender: Any) {
        let alertVC = UIAlertController(title: "Product Hunt", message: "Enter the number of days before you want to see the posts", preferredStyle: .alert)
        
        alertVC.addTextField { textField in
            
        }
        
        let okAction = UIAlertAction(title: "OK", style: .default) { action in
            self.postsData.removeAll()
            self.filteredPostData.removeAll()
            if let textField = alertVC.textFields?.first,
                let days = textField.text {
                let filteredUrl = "https://api.producthunt.com/v1/categories/tech/posts?days_ago=\(days)"
                self.fetchPosts(url: filteredUrl)
                self.postTableView.reloadData()
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { action in
            
        }
        
        alertVC.addAction(okAction)
        alertVC.addAction(cancelAction)
        
        self.present(alertVC, animated: true, completion: nil)
    }
    
}


// MARK: - UISearchBar

extension PostsVC: UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == ""{
            inSearchMode = false
            postTableView.reloadData()
            view.endEditing(true)
        }else{
            inSearchMode = true
            let text = searchBar.text!
            filteredPostData = postsData.filter({$0.name.range(of: text) != nil || $0.tagLine.range(of: text) != nil})
            postTableView.reloadData()
            
        }
    }
}

