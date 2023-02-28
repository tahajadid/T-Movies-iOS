//
//  HomeVC.swift
//  T-Movies-iOS
//
//  Created by Taha JADID on 27/2/2023.
//

import UIKit

class HomeVC: UIViewController {    

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // Hide navigationBar on the Top
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

}
