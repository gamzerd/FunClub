//
//  MediaFilterOption.swift
//  FunClub
//
//  Created by Gamze on 3/24/19.
//  Copyright © 2019 gamzerd. All rights reserved.
//

import Foundation

struct MediaFilterOption {
    
    var filterName: String = ""
    var value: String = ""
    var isSelected: Bool = false
    
    init(filterName: String = "",
         value:  String = "",
         isSelected: Bool = false)
    {
        self.filterName = filterName
        self.value = value
        self.isSelected = isSelected
    }
    
}
