//
//  CardViewModel.swift
//  SwipeMatch
//
//  Created by Weijie Lin on 1/2/19.
//  Copyright © 2019 Weijie Lin. All rights reserved.
//

import UIKit

protocol ProducesCardViewModel {
    func toCardViewModel() -> CardViewModel
}

class CardViewModel {
    
    let imageNames: [String]
    let attributedString: NSAttributedString
    let textAlignment: NSTextAlignment
    
    init(imageNames: [String], attributedString: NSAttributedString, textAlignment: NSTextAlignment) {
        self.imageNames = imageNames
        self.attributedString = attributedString
        self.textAlignment = textAlignment
    }
    
    fileprivate var imageIndex = 0
    
    func advanceToNextPhoto() {
        imageIndex = imageIndex + 1
    }
    
    func goToPreviousPhoto() {
        imageIndex = imageIndex - 1
    }
    
}

