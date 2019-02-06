//
//  RegistrationViewModel.swift
//  SwipeMatch
//
//  Created by Weijie Lin on 1/30/19.
//  Copyright © 2019 Weijie Lin. All rights reserved.
//

import UIKit
import Firebase

class RegistrationViewModel {

    var bindableIsRegistering = Bindable<Bool>()
    var bindableImage = Bindable<UIImage>()
    var bindableIsFormValid = Bindable<Bool>()
    
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
    
    func performRegistration(completion: @escaping (Error?) -> ()) {
        guard let email = email, let password = password else { return }
        bindableIsRegistering.value = true
        Auth.auth().createUser(withEmail: email, password: password) { (res, err) in
            if let err = err {
                print(err)
                completion(err)
                return
            }
            print("Successfully registered user: ", res?.user.uid ?? "")
            
            // Only upload images to Firebase Storage once you are authorized
            let filename = UUID().uuidString
            let ref = Storage.storage().reference(withPath: "/images/\(filename)")
            let imageData = self.bindableImage.value?.jpegData(compressionQuality: 0.75) ?? Data()
            let metaData = StorageMetadata()
            metaData.contentType = "image/jpeg"
            ref.putData(imageData, metadata: metaData, completion: { (_, err) in
                
                if let err = err {
                    completion(err)
                    return
                }
                
                print("Finished uploading image to storage.")
                
                ref.downloadURL(completion: { (url, err) in
                    if let err = err {
                        completion(err)
                        return
                    }
                    
                    self.bindableIsRegistering.value = false
                    print("Download url of image is: ", url?.absoluteString ?? "")
                    // store the download url into Firestore
                })
                
            })
        }
    }
    
    fileprivate func checkFormValidity() {
        let isFormValid = fullName?.isEmpty == false &&
            email?.isEmpty == false && password?.isEmpty == false
        bindableIsFormValid.value = isFormValid
    }
    
}
