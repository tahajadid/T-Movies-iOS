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
        
        let gestureSwipe = UISwipeGestureRecognizer(target: self, action:  #selector (self.dimissAll (_:)))
        gestureSwipe.direction = .right
        self.view.addGestureRecognizer(gestureSwipe)
    }

    @objc func dimissAll(_ sender: UISwipeGestureRecognizer){
        back()
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        back()
    }
    
    func back() {
        let splashVC = SplashVC()
        splashVC.showOnlyLogin = true
        splashVC.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        splashVC.modalPresentationStyle = .overFullScreen
        self.present(splashVC, animated: true, completion: nil)
    }
}
