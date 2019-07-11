//
//  SampleProject2Tests.swift
//  SampleProject2Tests
//
//  Created by Saurabh on 11/07/19.
//  Copyright © 2019 Saurabh. All rights reserved.
//

import XCTest
@testable import SampleProject2

class SampleProject2Tests: XCTestCase {

    /*
     Test Cases to verify that Model clas accepts the JSON format from URL.
     I have mock the data from JSON as in URL and save it in Local directory for unit testing, Mock data is in file named "PlaceMock.json"
     */
    
    func testJSONMapping() throws {
        let bundle = Bundle(for: type(of: self))
        
        guard let url = bundle.url(forResource: "PlaceMock", withExtension: "json") else {
            XCTFail("Missing file: PlaceMock.json")
            return
        }
        
        let json = try Data(contentsOf: url)
        
        let decoder = JSONDecoder()
        let place = try decoder.decode(Place.self, from: json)
        
        guard let title = place.title else {
            return
        }
        
        guard let rows = place.rows else {
            return
        }
        
        XCTAssertEqual(title, "About Canada")
        XCTAssertEqual(rows[0].title, "Beavers")
        XCTAssertEqual(rows[1].title, "Flag")
        XCTAssertEqual(rows[2].title, "Transportation")
        XCTAssertEqual(rows[1].description, nil)
    }
}
