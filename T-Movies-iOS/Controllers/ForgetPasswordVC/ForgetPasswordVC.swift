//
//  ForgetPasswordVC.swift
//  T-Movies-iOS
//
//  Created by Taha JADID on 14/3/2023.
//

import UIKit

class ForgetPasswordVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }


    @IBAction func backAction(_ sender: UIButton) {
        let splashVC = SplashVC()
        splashVC.showOnlyLogin = true
        splashVC.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        splashVC.modalPresentationStyle = .overFullScreen
        self.present(splashVC, animated: true, completion: nil)
    }
}
