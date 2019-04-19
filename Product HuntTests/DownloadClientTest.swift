//
//  DownloadClientTest.swift
//  Product HuntTests
//
//  Created by Vivek Rai on 19/04/19.
//  Copyright © 2019 Vivek Rai. All rights reserved.
//

import XCTest
@testable import Product_Hunt

class DownloadClientTest: XCTestCase {
    
    var sut: DownloadClient!
    var mockUrlSession: MockUrlSession!
    
    override func setUp() {
        sut = DownloadClient()
        mockUrlSession = MockUrlSession()
        sut.session = mockUrlSession as! SessionProtocol
        
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testDownloadUses_ExpectedHost(){
        let apiUrl = baseURL
        sut.downloadImage(withURL: apiUrl)
        guard let url = URL(string: apiUrl) else {XCTFail(); return}
        let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)
        XCTAssertEqual(urlComponents?.host, "api.producthunt.com")
        
    }
    
    func testDownloadUses_ExpectedPath(){
        let imageUrl = baseURL
        sut.downloadImage(withURL: imageUrl)
        guard let url = URL(string: "https://api.producthunt.com/v1/tech") else {XCTFail(); return}
        let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)
        XCTAssertEqual(urlComponents?.path, "/v1/tech")
        
    }
    
}

extension DownloadClientTest{
    class MockUrlSession{
        var url: URL?
        
        func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask{
            self.url = url
            return URLSession.shared.dataTask(with: url)
            
        }
    }
}
