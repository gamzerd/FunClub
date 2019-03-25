//
//  ItunesDataSourceTests.swift
//  FunClubTests
//
//  Created by Gamze on 3/25/19.
//  Copyright © 2019 gamzerd. All rights reserved.
//

import XCTest

@testable import FunClub

class ItunesDataSourceTests: XCTestCase {
    
    func testInit() {
        
        let ds = ItunesDataSource()
        XCTAssertNotNil(ds.api)
    }
    
    func testGetSearchResult() {
        
        // given
        let ds = ItunesDataSource()
        let service = MockService(url: "url/", defaultParams: [:])
        ds.api = service
        
        // when
        var responseReturnedFromCallback: SearchResponse?
        ds.getSearchResult(term: "lost", country: "US", media: "all", limit: 100).subscribe(onNext: { list in
            responseReturnedFromCallback = list
        }).dispose()
        
        // then
        XCTAssertEqual(service.callCount, 1)
        XCTAssertEqual(service.callParameterPath!, "/search")
        XCTAssertEqual(responseReturnedFromCallback!.results.count, 2)
        XCTAssertEqual(responseReturnedFromCallback!.results[0].trackName, "lost")
        XCTAssertEqual(responseReturnedFromCallback!.results[1].trackName, "lost2")
    }
    
    func testSaveVisitedItem() {
        
        // given
        let ds = ItunesDataSource()
        
        let mockDefaults = MockDefaults(returnValueOfArrayFunc: [1, 3])
        ds.defaults = mockDefaults
        
        let delegate1 = MockDataSourceDelegate()
        _ = ds.addDelegate(delegate: delegate1)
        
        let delegate2 = MockDataSourceDelegate()
        _ = ds.addDelegate(delegate: delegate2)
        
        // when
        ds.saveVisitedItem(id: 2)
        
        // then
        XCTAssertEqual(mockDefaults.setValueParameter as? [Int], [1, 3, 2])
        XCTAssertEqual(mockDefaults.setDefaultNameParameter, "VisitedItemListIds")
        
    }
    
    func testAddDeletedItem() {
        
        // given
        let ds = ItunesDataSource()
        
        let mockDefaults = MockDefaults(returnValueOfArrayFunc: [1, 3])
        ds.defaults = mockDefaults
        
        let delegate1 = MockDataSourceDelegate()
        _ = ds.addDelegate(delegate: delegate1)
        
        let delegate2 = MockDataSourceDelegate()
        _ = ds.addDelegate(delegate: delegate2)
        
        // when
        ds.addDeletedItem(id: 2)
        
        // then
        XCTAssertEqual(delegate1.didChangeDeletedItemStatusCount, 1)
        XCTAssertEqual(delegate1.didChangeDeletedItemStatusParameterId, 2)
        
        XCTAssertEqual(delegate2.didChangeDeletedItemStatusCount, 1)
        XCTAssertEqual(delegate2.didChangeDeletedItemStatusParameterId, 2)
        
        XCTAssertEqual(mockDefaults.setValueParameter as? [Int], [1, 3, 2])
        XCTAssertEqual(mockDefaults.setDefaultNameParameter, "DeletedItemListIds")
        
    }
    
}

class MockService: Service {
    
    var callCount = 0
    var callParameterPath: String?
    
    override  func get<E, D>(path: String, params: E, callback: @escaping (D?, Error?) -> Void) where E : Encodable, D : Decodable {
        callCount += 1
        callParameterPath = path
        
        if path == "/search" {
            let list: [Media] = [Media(trackName: "lost"), Media(trackName: "lost2")]
            let response = SearchResponse(results: list)
            callback((response as! D), nil)
        } else {
            let movie = Media(trackName: "oo")
            callback((movie as! D), nil)
        }
    }
}

class MockDefaults: UserDefaults {
    
    var returnValueOfArrayFunc: [Any]?
    
    var setValueParameter: Any?
    var setDefaultNameParameter: String?
    
    convenience init(returnValueOfArrayFunc: [Any] = []) {
        self.init()
        self.returnValueOfArrayFunc = returnValueOfArrayFunc
    }
    
    override func set(_ value: (Any)?, forKey defaultName: String) {
        setValueParameter = value
        setDefaultNameParameter = defaultName
    }
    
    override func array(forKey defaultName: String) -> [Any]? {
        return returnValueOfArrayFunc
    }
}

class MockDataSourceDelegate: DataSourceDelegateProtocol {
    
    var didChangeDeletedItemStatusCount = 0
    var didChangeDeletedItemStatusParameterId: Int?
    
    func didChangeDeletedItemStatus(id: Int) {
        didChangeDeletedItemStatusCount += 1
        didChangeDeletedItemStatusParameterId = id
    }
    
}



