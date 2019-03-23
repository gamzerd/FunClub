//
//  SearchRequest.swift
//  FunClub
//
//  Created by Gamze on 3/19/19.
//  Copyright © 2019 gamzerd. All rights reserved.
//

import Foundation

struct SearchRequest: Encodable {
    
    var term: String
    var country: String
    var media: String
    var limit: String

    init(term: String, country: String, media: String, limit: String) {
        self.term = term
        self.country = country
        self.media = media
        self.limit = limit
    }
}
