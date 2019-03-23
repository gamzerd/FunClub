//
//  AppConstants.swift
//  FunClub
//
//  Created by Gamze on 3/19/19.
//  Copyright © 2019 gamzerd. All rights reserved.
//

import UIKit

struct AppConstants {
    
    struct API {
        static let baseUrl = "https://itunes.apple.com"
    }
    
    struct MediaCollection {
        
        static let imageRatio: Float = 1.0 / 1.0
        static let numberOfColumnsInHorizontalGrid: Float = 1
        static let numberOfColumnsInVerticalGrid: Float = 2
        static let horizontalSpaceBetweenItems: Float = 8
        static let verticleSpaceBetweenItems: Float = 8
        static let collectionSectionTitleHeight: Float = 40
        
        static func getItemWidth(from totalWidth: Float) -> Float {
            return (totalWidth - horizontalSpaceBetweenItems * (getNumberOfColumns() + 1)) / getNumberOfColumns()
        }
        
        static func getNumberOfColumns() -> Float {
            
            switch UIDevice.current.orientation {
            case .portrait:
                return numberOfColumnsInVerticalGrid
            case .portraitUpsideDown:
                return numberOfColumnsInVerticalGrid
            case .landscapeLeft:
                return numberOfColumnsInHorizontalGrid
            case .landscapeRight:
                return numberOfColumnsInHorizontalGrid
            default:
                return numberOfColumnsInVerticalGrid
            }
        }
        
        static func getItemHeight(from totalWidth: Float) -> Float {
            let itemWidth = getItemWidth(from: totalWidth)
            return itemWidth * imageRatio
        }
        
        static func collectionHeight(from totalWidth: Float, itemCount: Int) -> Float {
            let itemHeight = getItemHeight(from: totalWidth) + verticleSpaceBetweenItems
            let rowCount = Float(itemCount) / numberOfColumnsInVerticalGrid
            return itemHeight * rowCount
        }
    }
}
