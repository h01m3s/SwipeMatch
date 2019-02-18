//
//  User.swift
//  SwipeMatch
//
//  Created by Weijie Lin on 12/22/18.
//  Copyright © 2018 Weijie Lin. All rights reserved.
//

import UIKit

struct User: ProducesCardViewModel {
    
    var name: String?
    var age: Int?
    var profession: String?
//    let imageNames: [String]
    var imageUrl1: String?
    var uid: String?
    
    init(dictionary: [String: Any]) {
        // initialize user
        self.age = dictionary["age"] as? Int
        self.profession = dictionary["profession"] as? String
        
        self.name = dictionary["fullName"] as? String ?? ""
        self.imageUrl1 = dictionary["imageUrl1"] as? String ?? ""
        self.uid = dictionary["uid"] as? String ?? ""
    }
    
    func toCardViewModel() -> CardViewModel {
        let attributedText = NSMutableAttributedString(string: name ?? "", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 32, weight: .heavy)])
        
        let ageString = age != nil ? "\(age!)" : "N\\A"
        
        attributedText.append(NSAttributedString(string: " \(ageString)", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 23, weight: .regular)]))
        
        let professionString = profession != nil ? profession! : "Not availabel"
        
        attributedText.append(NSAttributedString(string: "\n\(professionString)", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 23, weight: .regular)]))
        return CardViewModel(imageNames: [imageUrl1 ?? ""], attributedString: attributedText, textAlignment: .left)
    }
    
}
