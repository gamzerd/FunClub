//
//  MediaDetailTableViewCellTests.swift
//  FunClubTests
//
//  Created by Gamze on 3/25/19.
//  Copyright © 2019 gamzerd. All rights reserved.
//

import XCTest

@testable import FunClub

class MediaDetailTableViewCellTests: XCTestCase {

    func testSetup() {
        
        // given
        let nib = UINib(nibName: "MediaDetailTableViewCell", bundle: nil)
        let cell = nib.instantiate(withOwner: nil, options: [:]).first as! MediaDetailTableViewCell
        
        // when
        cell.setup(with: Media(trackName: "lost"))
        
        // then
        XCTAssertNotNil(cell.titleLabel)
        XCTAssertNotNil(cell.descLabel)
        XCTAssertNotNil(cell.mediaImage)
    }
    
}
