//
//  RegistrationViewModel.swift
//  SwipeMatch
//
//  Created by Weijie Lin on 1/30/19.
//  Copyright © 2019 Weijie Lin. All rights reserved.
//

import UIKit

class RegistrationViewModel {

    var bindableImage = Bindable<UIImage>()
    
    var fullName: String? {
        didSet {
            checkFormValidity()
        }
    }
    
    var email: String?{
        didSet {
            checkFormValidity()
        }
    }
    
    var password: String?{
        didSet {
            checkFormValidity()
        }
    }
    
    fileprivate func checkFormValidity() {
        let isFormValid = fullName?.isEmpty == false &&
            email?.isEmpty == false && password?.isEmpty == false
        bindableIsFormValid.value = isFormValid
//        isFormValidObserver?(isFormValid)
    }
    
    var bindableIsFormValid = Bindable<Bool>()
    
    // Reactive programming
//    var isFormValidObserver: ((Bool) -> ())?
}
