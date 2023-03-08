//
//  SplashVC.swift
//  T-Movies-iOS
//
//  Created by Taha JADID on 8/3/2023.
//

import UIKit
import Lottie

class SplashVC: UIViewController {

    @IBOutlet weak var AnimatedView: UIView!
    
    @IBOutlet weak var logoIamge: UIImageView!
    private var animationView: LottieAnimationView?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.logoIamge.alpha = 0
        logoIamge.fadeIn(1.5)  // uses custom duration (1.0 in this example)
        
        animationView = .init(name: "loading")
        animationView!.frame = AnimatedView.bounds
        animationView!.contentMode = .scaleAspectFill
        animationView!.loopMode = .loop
        AnimatedView.addSubview(animationView!)
        
        animationView?.isHidden = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.animationView?.isHidden = false
            self.animationView!.play()
        }
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            let mainTabBarViewController = MainTabBarViewController()
            mainTabBarViewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            mainTabBarViewController.modalPresentationStyle = .overFullScreen //or .overFullScreen for transparency
            self.present(mainTabBarViewController, animated: true, completion: nil)
        }
        
        
    }


}
