//
//  PostsDataModel.swift
//  Product Hunt
//
//  Created by Vivek Rai on 18/04/19.
//  Copyright © 2019 Vivek Rai. All rights reserved.
//

import Foundation

class PostsDataModel: Equatable {
    
    var name: String
    var tagLine: String
    var commentCount: Int
    var imageUrl: String
    var userId: String
    var postId: String
    
    init(name: String, tagLine: String, commentCount: Int, imageUrl: String, userId: String, postId: String) {
        self.name = name
        self.tagLine = tagLine
        self.commentCount = commentCount
        self.imageUrl = imageUrl
        self.userId = userId
        self.postId = postId
    }
    
    
    //    MARK: - UnitTest
    static func == (lhs: PostsDataModel, rhs: PostsDataModel) -> Bool {
        if lhs.name != rhs.name{
            return false
        }
        if lhs.tagLine != rhs.tagLine{
            return false
        }
        if lhs.commentCount != rhs.commentCount{
            return false
        }
        if lhs.imageUrl != rhs.imageUrl{
            return false
        }
        if lhs.userId != rhs.userId{
            return false
        }
        if lhs.postId != rhs.postId{
            return false
        }
    
        return true
    }
}
