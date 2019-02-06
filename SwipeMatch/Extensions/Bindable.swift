//
//  Bindable.swift
//  SwipeMatch
//
//  Created by Weijie Lin on 1/31/19.
//  Copyright © 2019 Weijie Lin. All rights reserved.
//

import Foundation

class Bindable<T> {
    
    var value: T? {
        didSet {
            observer?(value)
        }
    }
    
    var observer: ((T?) -> ())?
    
    func bind(observer: @escaping (T?) -> ()) {
        self.observer = observer
    }
    
}
