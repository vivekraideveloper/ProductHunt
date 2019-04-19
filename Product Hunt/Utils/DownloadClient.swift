//
//  DownloadClient.swift
//  Product Hunt
//
//  Created by Vivek Rai on 19/04/19.
//  Copyright © 2019 Vivek Rai. All rights reserved.
//


import Foundation

protocol SessionProtocol {
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

class DownloadClient {
    var session: SessionProtocol = URLSession.shared
    
    func downloadImage(withURL url: String) {
        guard let url = URL(string: url) else { fatalError() }
        session.dataTask(with: url) { (data, response, error) in
            //code to create image
            }.resume()
    }
    
}

extension URLSession: SessionProtocol {}

