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
    @IBOutlet weak var loginSectionView: UIView!
    
    @IBOutlet weak var faceidButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var fixLogo: UIImageView!
    @IBOutlet weak var designBottom: UIImageView!
    
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var viewH: NSLayoutConstraint!
    
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
        loginSectionView.isHidden = true
        fixLogo.isHidden = true
        designBottom.isHidden = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.animationView?.isHidden = false
            self.animationView!.play()
        }
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            // check if the user had already activated keep online
            var keepOnlineIsActivated = false
            if(keepOnlineIsActivated) {
                // navigate to home
                self.navigateToDestination()
            } else {
                self.loginBehavior()
            }
        }
        
        
        //Looks for single or multiple taps.
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
    }

    
    //Calls this function when the tap is recognized.
    @objc override func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    
    func navigateToDestination() {
        let mainTabBarViewController = MainTabBarViewController()
        mainTabBarViewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mainTabBarViewController.modalPresentationStyle = .overFullScreen //or .overFullScreen for transparency
        self.present(mainTabBarViewController, animated: true, completion: nil)
    }
    
    func loginBehavior() {
        AnimatedView.isHidden = true
        slideUpLogo()
        showLoginSection()
        initFields()
        
        loginButton.layer.cornerRadius = 6
        
        designBottom.isHidden = false
        designBottom.alpha = 0
        designBottom.fadeInDesign(0.5)

        //hideFaceIDIcon()
        
    }
    
    func initFields() {
        emailTextField.text = nil
        emailTextField.attributedPlaceholder = NSAttributedString(
            string: "test@gmail.com",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray]
        )
        
        passwordTextField.text = nil
        passwordTextField.attributedPlaceholder = NSAttributedString(
            string: "*******",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray]
        )
        passwordTextField.isSecureTextEntry = true
    }
    
    func hideFaceIDIcon() {
        // decrease the height of the mainVie
        viewH.constant -= 40
        // hide teh button
        faceidButton.isHidden = true
    }
    
    func slideUpLogo() {
        let oldCenterFirst = self.logoIamge.center
        let newCenterFirst = CGPoint(x: oldCenterFirst.x, y: oldCenterFirst.y - 0)

        // slide to center (where is actualy)
        UIView.animate(withDuration: 0, delay: 0, options: .curveLinear, animations: {
            self.logoIamge.center = newCenterFirst
        }) { (success: Bool) in
          print("Done top image")
        }
        
        // slide to top
        let newwCenterFirst = CGPoint(x: oldCenterFirst.x, y: oldCenterFirst.y - 220)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveLinear, animations: {
                self.logoIamge.center = newwCenterFirst
            }) { (success: Bool) in
              print("Done top image")
            }
        }

    }
    
    func showLoginSection() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
            self.fixLogo.isHidden = false
            self.logoIamge.isHidden = true
            
            self.loginSectionView.layer.cornerRadius = 10
            self.loginSectionView.isHidden = false
            self.loginSectionView.alpha = 0
            self.loginSectionView.fadeIn(0.5)
        }
    }


}
