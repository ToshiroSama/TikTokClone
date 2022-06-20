//
//  ProfileViewController.swift
//  TikTokClone
//
//  Created by Alisher Djuraev on 14/06/22.
//

import UIKit

class ProfileViewController: UIViewController {
    let user: User
    
    init(user: User) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = user.username.uppercased()
        view.backgroundColor = .systemBackground
    }
}
