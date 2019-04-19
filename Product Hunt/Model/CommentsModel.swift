//
//  CommentsModel.swift
//  Product Hunt
//
//  Created by Vivek Rai on 18/04/19.
//  Copyright © 2019 Vivek Rai. All rights reserved.
//

import Foundation

class CommentsModel: Equatable{

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
    
    static func == (lhs: CommentsModel, rhs: CommentsModel) -> Bool {
        if lhs.comments != rhs.comments{
            return false
        }
        if lhs.userId != rhs.userId{
            return false
        }
        if lhs.votes != rhs.votes{
            return false
        }
        if lhs.date != rhs.date{
            return false
        }

        
        return true
    }
}
