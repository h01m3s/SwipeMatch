//
//  CardView.swift
//  SwipeMatch
//
//  Created by Weijie Lin on 12/19/18.
//  Copyright © 2018 Weijie Lin. All rights reserved.
//

import UIKit
import SDWebImage

protocol CardViewDelegate {
    func didTapMoreInfo()
}

class CardView: UIView {
    
    var delegate: CardViewDelegate?
    
    var cardViewModel: CardViewModel! {
        didSet {
            let imageName = cardViewModel.imageNames.first ?? ""
//            imageView.image = UIImage(named: imageName)
            // load image using url
            if let url = URL(string: imageName) {
                imageView.sd_setImage(with: url)
            }
            
            informationLabel.attributedText = cardViewModel.attributedString
            informationLabel.textAlignment = cardViewModel.textAlignment
            
            (0..<cardViewModel.imageNames.count).forEach { (_) in
                let barView = UIView()
                barView.backgroundColor = barDeselectedColor
                barsStackView.addArrangedSubview(barView)
            }
            barsStackView.arrangedSubviews.first?.backgroundColor = .white
            
            setupImageIndexObserver()
        }
    }
    
    fileprivate func setupImageIndexObserver() {
        cardViewModel.imageIndexObserver = { [unowned self] (idx, imageUrl) in
            print("Changing photo from view model")
            
            if let url = URL(string: imageUrl ?? "") {
                self.imageView.sd_setImage(with: url)
            }
            
            self.barsStackView.arrangedSubviews.forEach({ (view) in
                view.backgroundColor = self.barDeselectedColor
            })
            self.barsStackView.arrangedSubviews[idx].backgroundColor = .white
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
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
    }
    
    fileprivate let barDeselectedColor = UIColor(white: 0, alpha: 0.1)
    
    @objc fileprivate func handleTap(gesture: UITapGestureRecognizer) {
        let tapLocation = gesture.location(in: nil)
        let shouldAdvanceNextPhoto = tapLocation.x > frame.width / 2 ? true : false
        
        if shouldAdvanceNextPhoto {
            cardViewModel.advanceToNextPhoto()
        } else {
            cardViewModel.goToPreviousPhoto()
        }
    }
    
    fileprivate let moreInfoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "info_icon").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleMoreInfo), for: .touchUpInside)
        return button
    }()
    
    @objc fileprivate func handleMoreInfo() {
        // hack solution
//        let rootViewController = UIApplication.shared.keyWindow?.rootViewController
//        let userDetailsController = UIViewController()
//        userDetailsController.view.backgroundColor = .yellow
//        rootViewController?.present(userDetailsController, animated: true)
        
        // use a delegate is more elegant
        delegate?.didTapMoreInfo()
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
        
        setupBarsStackView()
        
        addSubview(informationLabel)
        informationLabel.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 16, bottom: 16, right: 16))
        informationLabel.textColor = .white
        informationLabel.numberOfLines = 0
        
        addSubview(moreInfoButton)
        moreInfoButton.anchor(top: nil, leading: nil, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 16, right: 16), size: .init(width: 44, height: 44))
    }
    
    fileprivate let barsStackView = UIStackView()
    
    fileprivate func setupBarsStackView() {
        addSubview(barsStackView)
        barsStackView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 8, left: 8, bottom: 0, right: 8), size: .init(width: 0, height: 5))
        barsStackView.spacing = 4
        barsStackView.distribution = .fillEqually
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
