//
//  NotepadTests.swift
//  NotepadTests
//
//  Created by 王嘉宁 on 2020/3/2.
//  Copyright © 2020 王嘉宁. All rights reserved.
//

import XCTest
@testable import Notepad

class NotepadTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let result = CommonTools.mergeSort(list: [3,9,2,1,4,6,7,8,5,1]) { (left, right) -> Bool in
            return left > right
        }
        print(result)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
