//
//  ItunesDataSource.swift
//  FunClub
//
//  Created by Gamze on 3/19/19.
//  Copyright © 2019 gamzerd. All rights reserved.
//

import Foundation
import RxSwift

class ItunesDataSource: DataSourceProtocol {
  
    var api: ServiceProtocol
    var defaults = UserDefaults.standard
    final let visitedItemListIdsKey = "VisitedItemListIds"
    final let deletedItemListIdsKey = "DeletedItemListIds"

    var delegates: [DataSourceDelegateProtocol] = []

    init() {
        self.api = Service(
            url: AppConstants.API.baseUrl,
            defaultParams: [:]
        )
    }
    
    /**
     * Gets search result from api.
     * @param term: string to search
     * @param country: string country, default: US
     * @param media: string media type, default: all
     * @return [Media]
     */
    func getSearchResult(term: String, country: String, media: String, limit: Int) -> Observable<SearchResponse> {
        
        let requestParams = SearchRequest(term: term, country: country, media: media, limit: String(limit))
        
        return Observable<SearchResponse>.create { observer in
            self.api.get(path: "/search", params: requestParams, callback:
                { (data: SearchResponse?, error: Error?) -> Void in
                    if error == nil {
                        observer.onNext(data!)
                    } else {
                        observer.onError(error!)
                    }
                    observer.onCompleted()
            })
            
            return Disposables.create {
                
            }
        }
    }
    
    /**
     * Saves selected with given id
     * @param id: track id
     */
    func saveVisitedItem(id: Int) {
        
        // append visited item to the list
        var array = defaults.array(forKey: visitedItemListIdsKey) as? [Int] ?? [Int]()
        if !array.contains(id) {
            array.append(id)
        }
        
        // update visited item list in UserDefaults
        defaults.set(array, forKey: visitedItemListIdsKey)
        
    }
    
    func getVisitedItemList() -> Observable<[Int]> {
        
        return Observable.just(defaults.array(forKey: visitedItemListIdsKey) as? [Int] ?? [Int]())
    }
    
    /**
     * Adds deleted item with given id
     * @param id: track id
     */
    func addDeletedItem(id: Int) {
        
        // append deleted item to the list
        var array = defaults.array(forKey: deletedItemListIdsKey) as? [Int] ?? [Int]()
        if !array.contains(id) {
            array.append(id)
        }
        // update the deleted list in UserDefaults
        defaults.set(array, forKey: deletedItemListIdsKey)
        
        // notify all subscribers about the deleted items status change
        delegates.forEach { (delegate) in
            delegate.didChangeDeletedItemStatus(id: id)
        }
    }
    
    
    func getDeletedItemList() -> Observable<[Int]> {
        
        return Observable.just(defaults.array(forKey: deletedItemListIdsKey) as? [Int] ?? [Int]())
    }
    
    func addDelegate(delegate: DataSourceDelegateProtocol) -> Int {
        delegates.append(delegate)
        
        // return the index of the new item. It is used for removing delegate.
        return delegates.count - 1
    }
    
    func removeDelegate(index: Int) {
        delegates.remove(at: index)
    }
}
