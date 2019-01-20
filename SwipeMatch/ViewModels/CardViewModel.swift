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

struct CardViewModel {
    
    let imageName: String
    let attributedString: NSAttributedString
    let textAlignment: NSTextAlignment
    
}

