//
//  SimpleBannersTests.swift
//  SimpleBannersTests
//
//  Created by Filipe Merli on 09/12/19.
//  Copyright © 2019 Filipe Merli. All rights reserved.
//

import XCTest
@testable import SimpleBanners

class SimpleBannersTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testDecodeJsonMovie() {

        XCTAssertNoThrow(try JSONDecoder().decode(Movie.self, from: movieWithNoTitle))
        XCTAssertThrowsError(try JSONDecoder().decode(Movie.self, from: movieWithNoOverview))

    }
    
    private let movieWithNoTitle = Data("""
        {
            "title": null,
            "overview": "Long String"
        }
        """.utf8)
    
    private let movieWithNoOverview = Data("""
        {
            "title": "movie title",
            "overview": null
        }
        """.utf8)

}
