//
//  PostsVCTest.swift
//  Product HuntTests
//
//  Created by Vivek Rai on 19/04/19.
//  Copyright © 2019 Vivek Rai. All rights reserved.
//

import XCTest
@testable import Product_Hunt

class PostsVCTest: XCTestCase {
    
    var sut: PostsVC!
    
    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: "PostsVC") as? PostsVC
        sut.loadViewIfNeeded()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

   

}
