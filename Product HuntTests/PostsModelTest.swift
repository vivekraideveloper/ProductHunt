//
//  PostsModelTest.swift
//  Product HuntTests
//
//  Created by Vivek Rai on 19/04/19.
//  Copyright © 2019 Vivek Rai. All rights reserved.
//

import XCTest
@testable import Product_Hunt

class PostsModelTest: XCTestCase {
    
    var sut: PostsDataModel!
    
    override func setUp() {
        super.setUp()
        sut = PostsDataModel(name: "Damien", tagLine: "I am a spots geek", commentCount: 2, imageUrl: "https://damiensoprtslover.com", userId: "6896925", postId: "dbq76y2gu91")
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testInit_WhenTestValues_TakesValue(){
        
        let model1 = PostsDataModel(name: "Vivek", tagLine: "I am a Developer", commentCount: 3, imageUrl: "https://noUrlPlacedYet", userId: "767826", postId: "2y3huh83")
        let model2 = PostsDataModel(name: "Vivek", tagLine: "I am a Developer", commentCount: 3, imageUrl: "https://noUrlPlacedYet", userId: "767826", postId: "2y3huh83")
        
        XCTAssertEqual(model1.name, "Vivek")
        XCTAssertEqual(model1.tagLine, "I am a Developer")
        XCTAssertNotNil(model1.imageUrl)
        
        XCTAssertEqual(model1, model2)
    }
    
    func testValuesAreInitialized(){
        
        XCTAssertEqual(sut.commentCount, 2)
        XCTAssertNotNil(sut.name)
        XCTAssertNotNil(sut.imageUrl)
        XCTAssertNotNil(sut.postId)
        XCTAssertNotNil(sut.userId)
    }

    
    
}
