//
//  User.swift
//  SwipeMatch
//
//  Created by Weijie Lin on 12/22/18.
//  Copyright © 2018 Weijie Lin. All rights reserved.
//

import UIKit

struct User: ProducesCardViewModel {
    
    let name: String
    let age: Int
    let profession: String
    let imageName: String
    
    func toCardViewModel() -> CardViewModel {
        let attributedText = NSMutableAttributedString(string: name, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 32, weight: .heavy)])
        attributedText.append(NSAttributedString(string: " \(age)", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 23, weight: .regular)]))
        attributedText.append(NSAttributedString(string: "\n\(profession)", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 23, weight: .regular)]))
        return CardViewModel(imageName: imageName, attributedString: attributedText, textAlignment: .left)
    }
    
}
