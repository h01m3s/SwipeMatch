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

    let cardViewModels: [CardViewModel] = {
        let producers = [
            User(name: "Kelly", age: 23, profession: "Music DJ", imageName: "lady5c"),
            User(name: "Jane", age: 18, profession: "Teacher", imageName: "lady4c"),
            Advertiser(title: "Slide Out Menu", brandName: "Let's Build That App", posterPhotoName: "slide_out_menu_poster"),
            User(name: "Jane", age: 18, profession: "Teacher", imageName: "lady4c"),
            ] as [ProducesCardViewModel]
        
        let viewModels = producers.map { $0.toCardViewModel() }
        return viewModels
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupLayout()
        setupDummyCards()
    }
    
    fileprivate func setupDummyCards() {
        
        cardViewModels.forEach { (cardVM) in
            
            let cardView = CardView(frame: .zero)
            cardView.cardViewModel = cardVM
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

