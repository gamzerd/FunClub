//
//  DataSourceProtocol.swift
//  FunClub
//
//  Created by Gamze on 3/19/19.
//  Copyright © 2019 gamzerd. All rights reserved.
//

import Foundation
import RxSwift

protocol DataSourceProtocol {
    
    /**
     * Retrieves the result data from api.
     */
    func getSearchResult(term: String, country: String, media: String, limit: Int) -> Observable<SearchResponse>
    
    func saveVisitedItem(id: Int)
    
    func getVisitedItemList() -> Observable<[Int]>
    
    func addDeletedItem(id: Int)
    
    func getDeletedItemList() -> Observable<[Int]>
    
    func addDelegate(delegate: DataSourceDelegateProtocol) -> Int
    
    func removeDelegate(index: Int)

}

protocol DataSourceDelegateProtocol: class {
    
    func didChangeDeletedItemStatus(id: Int)
}

