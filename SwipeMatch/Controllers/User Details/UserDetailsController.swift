//
//  UserDetailsController.swift
//  SwipeMatch
//
//  Created by Weijie Lin on 4/11/19.
//  Copyright © 2019 Weijie Lin. All rights reserved.
//

import UIKit

class UserDetailsController: UIViewController, UIScrollViewDelegate {
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.alwaysBounceVertical = true
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.delegate = self
        return scrollView
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "lady4c"))
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let infoLabel: UILabel = {
        let label = UILabel()
        label.text = "User name 30\nDoctor\nSome bio text"
        label.numberOfLines = 0
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        view.addSubview(scrollView)
        scrollView.fillSuperview()
        
        scrollView.addSubview(imageView)
        imageView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.width)
        
        scrollView.addSubview(infoLabel)
        infoLabel.anchor(top: imageView.bottomAnchor, leading: scrollView.leadingAnchor, bottom: nil, trailing: scrollView.trailingAnchor, padding: .init(top: 16, left: 16, bottom: 0, right: 16))
        
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapDismiss)))
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let changeY = -scrollView.contentOffset.y
        print(changeY)
        if changeY < 100 {
            var width = view.frame.width + changeY * 2
            width = max(view.frame.width, width)
            let xyPosition = min(0, -changeY)
            imageView.frame = CGRect(x: xyPosition, y: xyPosition, width: width, height: width)
        } else {
            // add maximum image frame
            imageView.frame = CGRect(x: -100, y: -changeY, width: view.frame.width + 100 * 2, height: view.frame.width + 100 * 2)
        }
    }
    
    @objc fileprivate func handleTapDismiss() {
        dismiss(animated: true)
    }
    
}
