//
//  Advertiser.swift
//  SwipeMatch
//
//  Created by Weijie Lin on 1/16/19.
//  Copyright © 2019 Weijie Lin. All rights reserved.
//

import UIKit

struct Advertiser: ProducesCardViewModel {
    
    let title: String
    let brandName: String
    let posterPhotoName: String
    
    func toCardViewModel() -> CardViewModel {
        let attributedString = NSMutableAttributedString(string: title, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 34, weight: .heavy)])
        attributedString.append(NSAttributedString(string: "\n\(brandName)", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 24, weight: .bold)]))
        return CardViewModel(imageName: posterPhotoName, attributedString: attributedString, textAlignment: .center)
    }
    
}
