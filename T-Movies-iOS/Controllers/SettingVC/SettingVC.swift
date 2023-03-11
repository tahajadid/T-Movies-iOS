//
//  SettingVC.swift
//  T-Movies-iOS
//
//  Created by Taha JADID on 10/3/2023.
//

import UIKit
import Lottie

class SettingVC: UIViewController {
    
    @IBOutlet weak var AnimatedView: UIView!
    @IBOutlet weak var closeImage: UIButton!
    
    private var animationView: LottieAnimationView?

    override func viewDidLoad() {
        super.viewDidLoad()

        
        animationView = .init(name: "faceid")
        animationView!.frame = AnimatedView.bounds
        animationView!.contentMode = .scaleAspectFill
        animationView!.loopMode = .loop
        AnimatedView.addSubview(animationView!)
        
        self.animationView!.play()
        // Do any additional setup after loading the view.
    }

    @IBAction func closeClick(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    

}
