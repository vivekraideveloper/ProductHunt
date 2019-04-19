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
    
    func testPhotoDownload_ImageOrientationIsidentical(){
        let expectedImageOrientation = UIImage(named: "comment")?.imageOrientation
        guard let url = URL(string:"https://ph-files.imgix.net/c9f2ef68-ebb2-4c26-9a3b-7bdbae43128e?auto=format&fit=crop&h=570&w=430") else {XCTFail(); return}
        let sessionAnsweredExpectation = expectation(description: "Session")
    
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error{
                XCTFail(error.localizedDescription)
            }
            if let data = data{
                guard let image = UIImage(data: data) else {XCTFail(); return}
                sessionAnsweredExpectation.fulfill()
                XCTAssertEqual(image.imageOrientation, expectedImageOrientation)
            }
        }.resume()
    
        waitForExpectations(timeout: 800, handler: nil)
    
    }

    func testFetchPosts(){
        measure {
            sut.fetchPosts(url: baseURL)
        }
    }
   

}
