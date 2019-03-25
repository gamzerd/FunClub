//
//  MediaDetailViewControllerTests.swift
//  FunClubTests
//
//  Created by Gamze on 3/25/19.
//  Copyright © 2019 gamzerd. All rights reserved.
//

import XCTest
@testable import FunClub

class MediaDetailViewControllerTests: XCTestCase {

    func testViewDidLoad() {
        
        // given
        let viewModel = MockDetailViewModel()
        let viewController = MediaDetailViewController(viewModel: viewModel)
        
        // when
        _ = viewController.view
        
        // then
        XCTAssertNotNil(viewController.tableView)
    }
    
    func testPageTitle() {
        
        // given
        let viewModel = MockDetailViewModel()
        let viewController = MediaDetailViewController(viewModel: viewModel)
        
        // when
        _ = viewController.view
        
        // then
        XCTAssertEqual(viewController.title, "Media Detail Test Header")
    }
    
}

class MockDetailViewModel: MediaDetailViewModelProtocol {
    
    var media: Media = Media(trackName: "", artworkUrl100: "")
    
    func getTitle() -> String {
        return "Media Detail Test Header"
    }
    
    func didDeleteButtonClick() {
        
    }
}
