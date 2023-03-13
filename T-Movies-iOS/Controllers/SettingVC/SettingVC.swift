//
//  SettingVC.swift
//  T-Movies-iOS
//
//  Created by Taha JADID on 10/3/2023.
//

import UIKit
import Lottie
import LocalAuthentication

class SettingVC: UIViewController {
    
    @IBOutlet weak var AnimatedView: UIView!
    @IBOutlet weak var closeImage: UIButton!
    @IBOutlet weak var switchFaceID: UISwitch!
    
    
    private var animationView: LottieAnimationView?
    private var defaults: UserDefaults!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setSwitchState()

        animationView = .init(name: "faceid")
        animationView!.frame = AnimatedView.bounds
        animationView!.contentMode = .scaleAspectFill
        animationView!.loopMode = .loop
        AnimatedView.addSubview(animationView!)
        
        self.animationView!.play()
        
        switchFaceID.addTarget(self, action: #selector(stateChangedSwitch), for: .valueChanged)

    }

    @IBAction func closeClick(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @objc func stateChangedSwitch(switchState: UISwitch) {
       if switchFaceID.isOn {
           checkFaceID(false)
       } else {
           checkFaceID(true)
       }
    }

    // set Switch State depending on the value stored in UserDefaults
    func setSwitchState() {
        defaults = UserDefaults.standard
        switchFaceID.setOn(defaults.bool(forKey: Constants.FACEID_IS_ACTIVATED), animated: false)
    }
    
    // function that call the Face ID service
    func checkFaceID(_ actualValue: Bool) {
        let context = LAContext()
        var error: NSError?

        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Identify yourself!"

            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) {
                [weak self] success, authenticationError in

                DispatchQueue.main.async {
                    if success {
                        // change state of the switch
                        self?.switchFaceID.setOn(!actualValue, animated: true)
                        UserDefaults.standard.set(!actualValue, forKey: Constants.FACEID_IS_ACTIVATED)


                    } else {
                        // change state of the switch
                        self?.switchFaceID.setOn(actualValue, animated: true)
                        self?.showErrorFaceID()
                    }
                }
            }
        } else {
            showErorrNoBiometry()
        }
    }
    
    // show error in case of failure authentification
    func showErrorFaceID() {
        let ac = UIAlertController(title: "Authentication failed", message: "You could not be verified; please try again.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(ac, animated: true)
    }
    
    // show error in case of failure authentification
    func showErorrNoBiometry() {
        let ac = UIAlertController(title: "No Biometry", message: "Your phone does not support any method of Secure Authentification.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(ac, animated: true)
    }
}
