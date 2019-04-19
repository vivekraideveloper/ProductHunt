//
//  PostsCell.swift
//  Product Hunt
//
//  Created by Vivek Rai on 18/04/19.
//  Copyright © 2019 Vivek Rai. All rights reserved.
//

import UIKit

var imageCache: NSCache<AnyObject, AnyObject> = NSCache()

class PostsCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var tagLineLabel: UILabel!
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var commentCountLabel: UILabel!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func downloadImage(withUrlString urlString: String) {
        spinner.style = .whiteLarge
        spinner.hidesWhenStopped = true
        spinner.startAnimating()
        
        let url = URL(string: urlString)!
        
        if let imageFromCache = imageCache.object(forKey: url.absoluteString as AnyObject) as? UIImage {
            self.postImage.image = imageFromCache
            self.spinner.stopAnimating()
            return
        }
        
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            
            if error != nil {
                debugPrint(String(describing: error?.localizedDescription))
                return
            }
            
            DispatchQueue.main.async {
                let imageToCache = UIImage(data: data!)
                self.postImage.image = imageToCache
                self.spinner.stopAnimating()
                imageCache.setObject(imageToCache!, forKey: url.absoluteString as AnyObject)
            }
        }).resume()
    }

}
