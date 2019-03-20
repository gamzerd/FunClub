//
//  SearchResponse.swift
//  FunClub
//
//  Created by Gamze on 3/19/19.
//  Copyright © 2019 gamzerd. All rights reserved.
//

import Foundation

struct SearchResponse: Codable {
    
    var results: Array<Media>
    
    init(results: Array<Media>) {
        self.results = results
    }
}
