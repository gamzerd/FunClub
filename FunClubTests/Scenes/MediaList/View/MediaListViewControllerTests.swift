//
//  MediaListViewControllerTests.swift
//  FunClubTests
//
//  Created by Gamze on 3/25/19.
//  Copyright © 2019 gamzerd. All rights reserved.
//

import XCTest
@testable import FunClub

class MediaListViewControllerTests: XCTestCase {
    
    func testInit() {
        
        // given
        let ds = MockDataSource()
        let vm = MediaListViewModel(dataSource: ds)
        
        // when
        let vc = MediaListViewController(viewModel: vm)
        
        // then
        XCTAssertNotNil(vc.viewModel)
    }
    
    func testViewDidLoad() {
        
        // given
        let ds = MockDataSource()
        let viewModel = MediaListViewModel(dataSource: ds)
        let viewController = MediaListViewController(viewModel: viewModel)
        
        // when
        _ = viewController.view // triggers viewDidLoad
        
        // then
        XCTAssertNotNil(viewController.collectionView)
        XCTAssertEqual(viewController.title, "Media List")
    }
    
    func testRenderWithoutMedias() {
        
        // given
        let ds = MockDataSource()
        let viewModel = MediaListViewModel(dataSource: ds)
        let viewController = MediaListViewController(viewModel: viewModel)
        
        // when
        _ = viewController.view // triggers viewDidLoad
        
        // then
        XCTAssertEqual(viewController.collectionView.numberOfItems(inSection: 0), 0)
    }
    
    func testRenderMedias() {
        
        // given
        let ds = MockDataSource()
        let viewModel = MediaListViewModel(dataSource: ds)
        viewModel.list = [MediaListCellViewModel(isSelected: false, media: Media(trackName: "xyz")), MediaListCellViewModel(isSelected: false, media: Media(trackName: "abc"))]

        let viewController = MediaListViewController(viewModel: viewModel)
        
        // when
        _ = viewController.view // triggers viewDidLoad
        
        // then
        XCTAssertEqual(viewController.collectionView.numberOfItems(), 2)
    }
    
    func testRenderCellForMedias() {
        
        // given
        let ds = MockDataSource()
        let viewModel = MediaListViewModel(dataSource: ds)
        viewModel.list = [MediaListCellViewModel(isSelected: false, media: Media(trackName: "xyz")), MediaListCellViewModel(isSelected: true, media: Media(trackName: "abc"))]

        let viewController = MediaListViewController(viewModel: viewModel)
        
        // when
        _ = viewController.view // triggers viewDidLoad
        
        // then
        XCTAssertEqual(viewController.collectionView.title(at: 0), "xyz")
        XCTAssertEqual(viewController.collectionView.title(at: 1), "abc")
    }
    
    func testOpenPage() {
        
        // given
        let viewModel = MockViewModel()
        let viewController = MediaListViewController(viewModel: viewModel)
        let mockDelegate = MockShowDetailsCoordinatorDelegate()
        viewController.delegate = mockDelegate
        let media = Media(trackName: "lost")
        
        // when
        viewController.openPage(media: media)
        
        // then
        XCTAssertEqual(mockDelegate.showDetailsCount, 1)
        XCTAssertEqual(mockDelegate.showDetailsParameterMedia?.trackName, media.trackName)
        XCTAssertEqual(mockDelegate.showDetailsParameterFromViewController, viewController)
        
    }
    
}

private extension UICollectionView {
    func numberOfItems() -> Int {
        return numberOfItems(inSection: 0)
    }
    
    func cell(at row: Int) -> UICollectionViewCell? {
        return dataSource?.collectionView(self, cellForItemAt: IndexPath(row: row, section: 0))
        
    }
    
    func title(at row: Int) -> String? {
        let mediaCell = cell(at: row) as! MediaListCollectionViewCell
        return mediaCell.titleLabel.text
    }
}

class MockViewModel: MediaListViewModelProtocol {
  
    var viewDelegate: MediaListViewProtocol?
    
    var list: [MediaListCellViewModel] = []
    
    func load() {
        
    }
    
    func getTitle() -> String {
        return "Mock Title"
    }
    
    func didRowSelect(index: Int) {
        
    }
    
    func didPressLong(index: Int) -> UIViewController {
        return MediaDetailViewController()
    }
    
    func didAlertButtonClick() {
        
    }
    
    func didSearchInputChange(text: String) {
        
    }
    
    func didMediaFilterOptionSelect(option: String) {
        
    }
    
    func didFilterButtonClick() {
        
    }
    
    
   
}

class MockShowDetailsCoordinatorDelegate: ShowDetailsCoordinatorDelegate {
    
    var showDetailsCount = 0
    var showDetailsParameterMedia: Media?
    var showDetailsParameterFromViewController: UIViewController?
    
    func showDetails(media: Media, fromViewController: UIViewController) {
        showDetailsCount += 1
        showDetailsParameterMedia = media
        showDetailsParameterFromViewController = fromViewController
    }
}
