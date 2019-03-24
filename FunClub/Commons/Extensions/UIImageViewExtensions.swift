//
//  UIImageViewExtensions.swift
//  FunClub
//
//  Created by Gamze on 3/22/19.
//  Copyright © 2019 gamzerd. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func setImage(with url: String) {
        
        image = nil
        
        guard let imageURL = URL(string: url) else { return }
        
        let dataTask = URLSession.shared.dataTask(with: imageURL) { data, response, error in
            guard let data = data, error == nil,
                let image = UIImage(data: data) else { return }
                        
            DispatchQueue.main.async() {
                self.image = image
            }
        }
        dataTask.resume()
    }
}
