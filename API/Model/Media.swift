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
    var artworkUrl60: String = ""
    
    init(wrapperType: String = "",
         artworkUrl60:  String = "")
    {
        self.wrapperType = wrapperType
        self.artworkUrl60 = artworkUrl60
    }

}
