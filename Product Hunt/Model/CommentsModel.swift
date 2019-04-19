//
//  CommentsModel.swift
//  Product Hunt
//
//  Created by Vivek Rai on 18/04/19.
//  Copyright © 2019 Vivek Rai. All rights reserved.
//

import Foundation

class CommentsModel {
    
    var comments: String
    var userId: String
    var votes: Int
    var date: String
    
    init(comments: String, userId: String, votes: Int, date: String) {
        self.comments = comments
        self.userId = userId
        self.votes = votes
        self.date = date
    }
}
