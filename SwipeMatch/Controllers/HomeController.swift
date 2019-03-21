//
//  ViewController.swift
//  SwipeMatch
//
//  Created by Weijie Lin on 12/18/18.
//  Copyright © 2018 Weijie Lin. All rights reserved.
//

import UIKit
import Firebase

class HomeController: UIViewController {

    let topStackView = TopNavigationStackView()
    let cardsDeckView = UIView()
    let bottonsStackView = HomeBottomControlsStackView()

//    let cardViewModels: [CardViewModel] = {
//        let producers = [
//            User(name: "Kelly", age: 23, profession: "Music DJ", imageNames: ["kelly1", "kelly2", "kelly3"]),
//            Advertiser(title: "Slide Out Menu", brandName: "Let's Build That App", posterPhotoName: "slide_out_menu_poster"),
//            User(name: "Jane", age: 18, profession: "Teacher", imageNames: ["jane1", "jane2", "jane3"]),
//            ] as [ProducesCardViewModel]
//
//        let viewModels = producers.map { $0.toCardViewModel() }
//        return viewModels
//    }()
    
    var cardViewModels = [CardViewModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        topStackView.settingsButton.addTarget(self, action: #selector(handleSettings), for: .touchUpInside)

        setupLayout()
        setupFirestoreUserCards()
        
        fetchUsersFromFirestore()
    }
    
    fileprivate func fetchUsersFromFirestore() {
//        let query = Firestore.firestore().collection("users")
        let query = Firestore.firestore().collection("users").whereField("age", isGreaterThan: 1)
        query.getDocuments { (snapshot, err) in
            if let err = err {
                print("Failed to fetch users: ", err.localizedDescription)
                return
            }
            
            snapshot?.documents.forEach({ (documentSnapshot) in
                let userDictionary = documentSnapshot.data()
                print(userDictionary)
                let user = User(dictionary: userDictionary)
                self.cardViewModels.append(user.toCardViewModel())
            })
            self.setupFirestoreUserCards()
        }
    }
    
    @objc fileprivate func handleSettings() {
        print("Show registration page")
        let registrationController = RegistrationController()
        present(registrationController, animated: true)
    }
    
    fileprivate func setupFirestoreUserCards() {
        cardViewModels.forEach { (cardVM) in
            let cardView = CardView(frame: .zero)
            cardView.cardViewModel = cardVM
            cardsDeckView.addSubview(cardView)
            cardView.fillSuperview()
        }
    }
    
    // MARK:- Fileprivate
    fileprivate func setupLayout() {
        
        view.backgroundColor = .white
        
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

