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
    final let selectedItemListIdsKey = "SelectedItemListIds"
    
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
    func saveSelectedItem(id: Int) {
        
        // append new favourite to the list
        var array = defaults.array(forKey: selectedItemListIdsKey) as? [Int] ?? [Int]()
        array.append(id)
        
        // update the favourite list in UserDefaults
        defaults.set(array, forKey: selectedItemListIdsKey)
        
    }
    
    func getSelectedItemList() -> Observable<[Int]> {
        
        return Observable.just(defaults.array(forKey: selectedItemListIdsKey) as? [Int] ?? [Int]())
    }
}
