//
//  HomeVC.swift
//  T-Movies-iOS
//
//  Created by Taha JADID on 27/2/2023.
//

import UIKit
import Combine

class HomeVC: UIViewController {    
    // Hide navigationBar on the Top
    // Show tabBar
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        self.tabBarController?.tabBar.isHidden = false

    }

    // Hide navigationBar on the Top
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

}
