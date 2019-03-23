//
//  Media.swift
//  FunClub
//
//  Created by Gamze on 3/19/19.
//  Copyright © 2019 gamzerd. All rights reserved.
//

import Foundation

class Media: Codable {
    
    var wrapperType: String = ""
    var artworkUrl100: String = ""
    
    init(wrapperType: String = "",
         artworkUrl100:  String = "")
    {
        self.wrapperType = wrapperType
        self.artworkUrl100 = artworkUrl100
    }

}
