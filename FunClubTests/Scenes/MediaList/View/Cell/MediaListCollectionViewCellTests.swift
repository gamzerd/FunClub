//
//  MediaListCollectionViewCellTests.swift
//  FunClubTests
//
//  Created by Gamze on 3/25/19.
//  Copyright © 2019 gamzerd. All rights reserved.
//

import XCTest
@testable import FunClub

class MediaListCollectionViewCellTests: XCTestCase {
    
    func testSetup() {
        
        let nib = UINib(nibName: "MediaListCollectionViewCell", bundle: nil)
        let cell = nib.instantiate(withOwner: nil, options: [:]).first as! MediaListCollectionViewCell
        
        cell.setup(with: MediaListCellViewModel(isSelected: false, media: Media(trackName: "lost")))

        XCTAssertNotNil(cell.mediaImageView)
        XCTAssertEqual(cell.titleLabel.text, "lost")
    }
    
}
