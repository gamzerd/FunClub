//
//  MediaListViewModelTests.swift
//  FunClubTests
//
//  Created by Gamze on 3/25/19.
//  Copyright © 2019 gamzerd. All rights reserved.
//


import XCTest
import RxSwift

@testable import FunClub

class MediaListViewModelTests: XCTestCase {
    
    func testInit() {
        
        // when
        let vm = MediaListViewModel(dataSource: MockDataSource())
        
        // then
        XCTAssertNotNil(vm.dataSource)
        XCTAssertNotNil(vm.list)
        XCTAssertEqual(vm.list.count, 0)
    }
    
    func testGetTitle() {
        
        // given
        let vm = MediaListViewModel(dataSource: MockDataSource())
        
        // when, then
        XCTAssertEqual(vm.getTitle(), "Media List")
    }
    
    func testDidRowSelect() {
        
        // given
        let vm = MediaListViewModel(dataSource: MockDataSource())
        vm.list = [MediaListCellViewModel(isSelected: false, media: Media(trackName: "xyz")), MediaListCellViewModel(isSelected: false, media: Media(trackName: "abc"))]
        
        let view = MockView()
        vm.viewDelegate = view
        
        // when
        vm.didRowSelect(index: 0)
        
        // then
        XCTAssertEqual(view.openPageCount, 1)
        XCTAssertNotNil(view.openPageParameter)
        XCTAssertEqual(view.openPageParameter?.trackName, "xyz")
    }
    
}

enum APIError: Error {
    case NetworkFail()
}

class MockDataSource: DataSourceProtocol {
    
    // returned as mock response in getSearchResult function
    var expectedList: SearchResponse?
    
    var expectedMedia: Media?
    
    var getSearchResultCount = 0
    var getSearchResultParameterTerm: String?
    var getSearchResultParameterCountry: String?
    var getSearchResultParameterMedia: String?
    var getSearchResultParameterLimit: Int?
    
    var saveVisitedItemCount = 0
    var saveVisitedItemParameter: Int?
    
    var addDeleteItemCount = 0
    var addDeleteItemParameter: Int?
    
    var getDeletedItemListCount = 0
    
    var getVisitedItemListCount = 0
    
    var addDelegateCount = 0
    var addDelegateParameter: DataSourceDelegateProtocol?
    
    var removeDelegateCount = 0
    var removeDelegateParameter: Int?
    
    func getSearchResult(term: String, country: String, media: String, limit: Int) -> Observable<SearchResponse> {
        getSearchResultCount += 1
        getSearchResultParameterTerm = term
        getSearchResultParameterCountry = country
        getSearchResultParameterMedia = media
        getSearchResultParameterLimit = limit
        
        if let list = expectedList {
            return Observable.just(list)
        } else {
            return Observable.error(APIError.NetworkFail())
        }
    }
    
    func saveVisitedItem(id: Int) {
        saveVisitedItemCount += 1
        saveVisitedItemParameter = id
    }
    
    func addDeletedItem(id: Int) {
        addDeleteItemCount += 1
        addDeleteItemParameter = id
    }
    
    func getDeletedItemList() -> Observable<[Int]> {
        getDeletedItemListCount += 1
        return Observable.just([])
    }
    
    func getVisitedItemList() -> Observable<[Int]> {
        getVisitedItemListCount += 1
        return Observable.just([])
    }
    
    func addDelegate(delegate: DataSourceDelegateProtocol) -> Int {
        addDelegateCount += 1
        addDelegateParameter = delegate
        return 0
    }
    
    func removeDelegate(index: Int) {
        removeDelegateCount += 1
        removeDelegateParameter = index
    }
    
    
}

class MockView: MediaListViewProtocol {
   
    var showListCallCount = 0
    var showListCallParameterIndexToUpdate: Int?
    var showListCallParameterIndexToDelete: Int?
    
    var openPageCount = 0
    var openPageParameter: Media?
    
    var showHideMessageCount = 0
    var showHideMessageParameter: Bool?
    
    var showMediaFilterCount = 0
    var showMediaFilterParameter: [MediaFilterOption]?
    
    var showAlertCount = 0
    var showAlertParameterTitle: String?
    var showAlertParameterMessage: String?
    var showAlertParameterButtonTitle: String?
    
    func showList(indexToUpdate: Int, indexToDelete: Int) {
        showListCallCount += 1
        showListCallParameterIndexToDelete = indexToDelete
        showListCallParameterIndexToUpdate = indexToUpdate
    }
    
    func openPage(media: Media) {
        openPageCount += 1
        openPageParameter = media
    }
    
    func showHideMessage(isHidden: Bool) {
        showHideMessageCount += 1
        showHideMessageParameter = isHidden
    }
    
    func showMediaFilter(options: [MediaFilterOption]) {
        showMediaFilterCount += 1
        showMediaFilterParameter = options
    }
    
    func showAlert(alertTitle: String, alertMessage: String, buttonTitle: String?) {
        showAlertCount += 1
        showAlertParameterTitle = alertTitle
        showAlertParameterMessage = alertMessage
        showAlertParameterButtonTitle = buttonTitle
    }
    
}

