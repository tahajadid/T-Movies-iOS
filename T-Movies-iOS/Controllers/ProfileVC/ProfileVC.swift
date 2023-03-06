//
//  ProfileVC.swift
//  T-Movies-iOS
//
//  Created by Taha JADID on 28/2/2023.
//

import UIKit

class ProfileVC: UIViewController {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var profileImageBg: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        profileImage.layer.masksToBounds = false
        profileImage.layer.cornerRadius = profileImage.frame.height/2
        profileImage.clipsToBounds = true
        
        profileImageBg.layer.masksToBounds = false
        profileImageBg.layer.cornerRadius = profileImageBg.frame.height/2
        profileImageBg.clipsToBounds = true
        // Do any additional setup after loading the view.
    }
    
    // Hide navigationBar on the Top
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        self.tabBarController?.tabBar.isHidden = false
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

}
