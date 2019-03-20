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
    func getSearchResult(term: String, country: String, media: String) -> Observable<[Media]> {
        
        let requestParams = SearchRequest(term: term, country: country, media: media)
        
        return Observable<[Media]>.create { observer in
            self.api.get(path: "/search", params: requestParams, responseType: SearchResponse.self, callback:
                { (data: SearchResponse?, error: Error?) -> Void in
                    if error == nil {
                        observer.onNext((data?.results)!)
                    } else {
                        observer.onError(error!)
                    }
                    observer.onCompleted()
            })
            
            return Disposables.create {
                
            }
        }
    }
}
