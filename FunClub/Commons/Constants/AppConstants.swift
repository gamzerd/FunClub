//
//  AppConstants.swift
//  FunClub
//
//  Created by Gamze on 3/19/19.
//  Copyright © 2019 gamzerd. All rights reserved.
//

import Foundation

struct AppConstants {
    
    struct API {
        static let baseUrl = "https://itunes.apple.com"
    }
    
    struct MediaCollection {
        static let ImageRatio: Float = 1.0 / 1.0
        static let NumberOfColumnsInGrid: Float = 2
        static let HorizontalSpaceBetweenItems: Float = 8
        static let VerticleSpaceBetweenItems: Float = 8
        static let CollectionSectionTitleHeight: Float = 40
        
        static func getItemWidth(from totalWidth: Float) -> Float {
            return (totalWidth - AppConstants.MediaCollection.HorizontalSpaceBetweenItems * (NumberOfColumnsInGrid + 1)) / NumberOfColumnsInGrid
        }
        
        static func getItemHeight(from totalWidth: Float) -> Float {
            let itemWidth = getItemWidth(from: totalWidth)
            return itemWidth * ImageRatio
        }
        
        static func collectionHeight(from totalWidth: Float, itemCount: Int) -> Float {
            let itemHeight = AppConstants.MediaCollection.getItemHeight(from: totalWidth) + VerticleSpaceBetweenItems
            let rowCount = Float(itemCount) / AppConstants.MediaCollection.NumberOfColumnsInGrid
            return itemHeight * rowCount
        }
    }
}
