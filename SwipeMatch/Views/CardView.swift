//
//  CardView.swift
//  SwipeMatch
//
//  Created by Weijie Lin on 12/19/18.
//  Copyright © 2018 Weijie Lin. All rights reserved.
//

import UIKit

class CardView: UIView {
    
    var cardViewModel: CardViewModel! {
        didSet {
            imageView.image = UIImage(named: cardViewModel.imageName)
            informationLabel.attributedText = cardViewModel.attributedString
            informationLabel.textAlignment = cardViewModel.textAlignment
        }
    }
    
    // Encapsulation
    fileprivate let imageView = UIImageView(image: #imageLiteral(resourceName: "lady5c"))
    fileprivate let informationLabel = UILabel()
    fileprivate let gradientLayer = CAGradientLayer()
    
    // Configurations
    fileprivate let threshold: CGFloat = 100

    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        addGestureRecognizer(panGesture)
    }
    
    fileprivate func setupLayout() {
        layer.cornerRadius = 19
        clipsToBounds = true
        
        imageView.contentMode = .scaleAspectFill
        addSubview(imageView)
        imageView.fillSuperview()
        
        // Add a gradient layer
        // gradientLayer has to be setup before informationLabel due to z-index
        setupGradientLayer()
        
        addSubview(informationLabel)
        informationLabel.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 16, bottom: 16, right: 16))
        informationLabel.textColor = .white
        informationLabel.numberOfLines = 0
    }
    
    fileprivate func setupGradientLayer() {
        
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        // layer from middle to outside of frame
        gradientLayer.locations = [0.5, 1.1]
//         self.frame is zero during init
//        gradientLayer.frame = self.frame
        layer.addSublayer(gradientLayer)
    }
    
    override func layoutSubviews() {
        // Here will know CardView frame will be
        gradientLayer.frame = self.frame
    }

    @objc fileprivate func handlePan(gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .began:
            superview?.subviews.forEach({ (subView) in
                subView.layer.removeAllAnimations()
            })
        case .changed:
            handlePanGestureStateChanged(gesture)
        case .ended:
            handlePanGestureEnded(gesture)
        default:
            ()
        }
    }
    
    fileprivate func handlePanGestureStateChanged(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: nil)
        // Rotation
        // convert radians to degrees
        let degrees: CGFloat = translation.x / 20
        let angle = degrees * .pi / 180
        let rotationalTransformation = CGAffineTransform(rotationAngle: angle)
        self.transform = rotationalTransformation.translatedBy(x: translation.x, y: translation.y)
    }
    
    fileprivate func handlePanGestureEnded(_ gesture: UIPanGestureRecognizer) {
        let translationDirection: CGFloat = gesture.translation(in: nil).x > 0 ? 1 : -1
        let shouldDismissCard = abs(gesture.translation(in: nil).x) > threshold

        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.1, options: .curveEaseOut, animations: {
            
            if shouldDismissCard {
                
                self.frame = CGRect(x: 1000 * translationDirection, y: 0, width: self.frame.width, height: self.frame.height)

            } else {
                self.transform = .identity
            }
            
        }) { (_) in
            
            self.transform = .identity
            if shouldDismissCard {
                self.removeFromSuperview()
            }
//            self.frame = CGRect(x: 0, y: 0, width: self.superview!.frame.width, height: self.superview!.frame.height)
            
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
