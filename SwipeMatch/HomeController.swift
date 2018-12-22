//
//  ViewController.swift
//  SwipeMatch
//
//  Created by Weijie Lin on 12/18/18.
//  Copyright © 2018 Weijie Lin. All rights reserved.
//

import UIKit

class HomeController: UIViewController {

    let topStackView = TopNavigationStackView()
    let cardsDeckView = UIView()
    let bottonsStackView = HomeBottomControlsStackView()
    
    let users = [
        User(name: "Kelly", age: 23, profession: "Music DJ", imageName: "lady5c"),
        User(name: "Jane", age: 18, profession: "Teacher", imageName: "lady4c")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupLayout()
        setupDummyCards()
    }
    
    fileprivate func setupDummyCards() {
        
        users.forEach { (user) in
            let cardView = CardView()
            cardView.imageView.image = UIImage(named: user.imageName)
            cardView.informationLabel.text = "\(user.name) \(user.age)\n\(user.profession)"
            let attributedText = NSMutableAttributedString(string: user.name, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 32, weight: .heavy)])
            attributedText.append(NSAttributedString(string: " \(user.age)", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 23, weight: .regular)]))
            attributedText.append(NSAttributedString(string: "\n\(user.profession)", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 23, weight: .regular)]))
            cardView.informationLabel.attributedText = attributedText
            
            cardsDeckView.addSubview(cardView)
            cardView.fillSuperview()
        }
        
    }
    
    // MARK:- Fileprivate
    fileprivate func setupLayout() {
        
        // The way UIKit manage all the subviews for a particular component such as a UIStackView
        // is to assign all these subviews a z-index, so the view appears first has lower z-index
        // That's way topStackView is below cardsDeckView and bottonsStack is above cardsDeckView
        let overallStackView = UIStackView(arrangedSubviews: [topStackView, cardsDeckView, bottonsStackView])
        overallStackView.axis = .vertical
        
        view.addSubview(overallStackView)
        overallStackView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor)
        overallStackView.isLayoutMarginsRelativeArrangement = true
        overallStackView.layoutMargins = .init(top: 0, left: 12, bottom: 0, right: 12)
        
        overallStackView.bringSubviewToFront(cardsDeckView)
    }

}

