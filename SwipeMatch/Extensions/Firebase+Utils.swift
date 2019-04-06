//
//  Firebase+Utils.swift
//  SwipeMatch
//
//  Created by Weijie Lin on 4/5/19.
//  Copyright © 2019 Weijie Lin. All rights reserved.
//

import Firebase

extension Firestore {
    
    func fetchCurrentUser(completion: @escaping (Result<User, Error>) -> ()) {
        
        guard let uid = Auth.auth().currentUser?.uid else {
            print("No user logged in.")
            return
        }
        Firestore.firestore().collection("users").document(uid).getDocument { (snapshot, err) in
            if let err = err {
                completion(.failure(err))
                return
            }
            
            // fetch success
            guard let dictionary = snapshot?.data() else { return }
            let user = User(dictionary: dictionary)
            completion(.success(user))
        }
        
    }
    
}
