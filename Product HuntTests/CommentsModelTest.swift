//
//  CommentsModelTest.swift
//  Product HuntTests
//
//  Created by Vivek Rai on 19/04/19.
//  Copyright © 2019 Vivek Rai. All rights reserved.
//

import XCTest
@testable import Product_Hunt

class CommentsModelTest: XCTestCase {

    var sut: CommentsModel!
    
    override func setUp() {
        super.setUp()
        sut = CommentsModel(comments: "I am commenting", userId: "hue76826ge", votes: 6, date: "2017-12-23")
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testInit_WhenTestValues_TakesValue(){
        
        let model1 = CommentsModel(comments: "This is a comment", userId: "67yhb8", votes: 6, date: "2017-12-23")
        let model2 = CommentsModel(comments: "This is a comment", userId: "67yhb8", votes: 6, date: "2017-12-23")
        
        XCTAssertEqual(model1.comments, "This is a comment")
        XCTAssertEqual(model1.votes, 6)
        XCTAssertNotNil(model1.date)
        
        XCTAssertEqual(model1, model2)
    }
    
    func testValuesAreInitialized(){
        
        XCTAssertEqual(sut.comments, "I am commenting")
        XCTAssertNotNil(sut.date)
        XCTAssertNotNil(sut.votes)
        XCTAssertNotNil(sut.userId)
    }
    
    
    
}
