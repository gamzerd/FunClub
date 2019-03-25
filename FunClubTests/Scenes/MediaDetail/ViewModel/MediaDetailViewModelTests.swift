//
//  MediaDetailViewModelTests.swift
//  FunClubTests
//
//  Created by Gamze on 3/25/19.
//  Copyright © 2019 gamzerd. All rights reserved.
//

import XCTest
@testable import FunClub

class MediaDetailViewModelTests: XCTestCase {
    
    func testInit() {
        
        let vm = MediaDetailViewModel(dataSource: MockDataSource(), media: Media(trackName: ""))
        
        XCTAssertNotNil(vm.media)
        XCTAssertNotNil(vm.dataSource)

    }
    
    func testGetTitle() {
        
        let vm = MediaDetailViewModel(dataSource: MockDataSource(), media: Media(trackName: ""))
        
        XCTAssertEqual(vm.getTitle(), "Selected Item")
    }

}

