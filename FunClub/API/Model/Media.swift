//
//  Media.swift
//  FunClub
//
//  Created by Gamze on 3/19/19.
//  Copyright © 2019 gamzerd. All rights reserved.
//

import Foundation

class Media: Codable {
    
    var kind: String?
    var artworkUrl100: String
    var trackId: Int?
    var trackName: String = ""
    
    init(trackName: String,
         artworkUrl100: String = "") {
        self.trackName = trackName
        self.artworkUrl100 = artworkUrl100
    }

}
