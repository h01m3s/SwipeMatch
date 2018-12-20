//
//  ViewController.swift
//  SwipeMatch
//
//  Created by Weijie Lin on 12/18/18.
//  Copyright © 2018 Weijie Lin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let topStackView = TopNavigationStackView()
    let blueView = UIView()
    let bottonsStackView = HomeBottomControlsStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        blueView.backgroundColor = .blue
        
        setupLayout()
    }
    
    // MARK:- Fileprivate
    fileprivate func setupLayout() {
        let overallStackView = UIStackView(arrangedSubviews: [topStackView, blueView, bottonsStackView])
        overallStackView.axis = .vertical
        
        view.addSubview(overallStackView)
        overallStackView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor)
    }

}

