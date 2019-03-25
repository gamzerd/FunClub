//
//  AppContainerTests.swift
//  FunClubTests
//
//  Created by Gamze on 3/25/19.
//  Copyright © 2019 gamzerd. All rights reserved.
//

import XCTest

@testable import FunClub

class AppContainerTests: XCTestCase {
    
    func testInit() {
        
        let container = AppContainer()
        
        XCTAssertNotNil(container.dataSource)
        XCTAssertNotNil(container.router)
    }
}


