//
//  AgeRangeCell.swift
//  SwipeMatch
//
//  Created by Weijie Lin on 4/1/19.
//  Copyright © 2019 Weijie Lin. All rights reserved.
//

import UIKit

class AgeRangeCell: UITableViewCell {
    
    let minSlider: UISlider = {
        let slier = UISlider()
        slier.minimumValue = 18
        slier.maximumValue = 100
        return slier
    }()
    
    let maxSlider: UISlider = {
        let slier = UISlider()
        slier.minimumValue = 18
        slier.maximumValue = 100
        return slier
    }()
    
    let minLabel: UILabel = {
        let label = AgeRangeLabel()
        label.text = "Min: 18"
        return label
    }()
    
    let maxLabel: UILabel = {
        let label = AgeRangeLabel()
        label.text = "Max: 18"
        return label
    }()
    
    class AgeRangeLabel: UILabel {
        override var intrinsicContentSize: CGSize {
            return .init(width: 80, height: 0)
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let overallStackView = UIStackView(arrangedSubviews: [
            UIStackView(arrangedSubviews: [minLabel, minSlider]),
            UIStackView(arrangedSubviews: [maxLabel, maxSlider])
            ])
        overallStackView.axis = .vertical
        overallStackView.spacing = 16
        addSubview(overallStackView)
        overallStackView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 16, left: 16, bottom: 16, right: 16))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
