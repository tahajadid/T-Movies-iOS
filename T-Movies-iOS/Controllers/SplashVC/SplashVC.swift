//
//  SplashVC.swift
//  T-Movies-iOS
//
//  Created by Taha JADID on 8/3/2023.
//

import UIKit
import Lottie
import LocalAuthentication

class SplashVC: UIViewController {

    // MARK: - UI

    @IBOutlet weak var AnimatedView: UIView!
    @IBOutlet weak var logoIamge: UIImageView!
    @IBOutlet weak var loginSectionView: UIView!
    
    @IBOutlet weak var faceidButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var fixLogo: UIImageView!
    @IBOutlet weak var designBottom: UIImageView!
    @IBOutlet weak var forgetButton: UIButton!
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var centerLoading: UIView!
    
    @IBOutlet weak var emailEmpty: UILabel!
    @IBOutlet weak var passwordEmpty: UILabel!
    
    @IBOutlet weak var viewH: NSLayoutConstraint!
    
    // MARK: - Variables

    private var animationView: LottieAnimationView?
    private var loginAnimationView: LottieAnimationView?

    private var faceidIsActivated: Bool!
    private var keepOnline: Bool!
    
    public var showOnlyLogin = false
    var errorFieldEnabled = false

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getDataFromCache()
        
        initUIComponents()
        
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
    
    @IBAction func loginAction(_ sender: UIButton) {
        navigateToDestination()
    }
    
    @IBAction func faceIdAction(_ sender: UIButton) {
        checkFaceID()
    }
    
    
    func showLoginLoader() {
        loadingView.isHidden = false
        centerLoading.isHidden = false
        
        loadingView.layer.cornerRadius = 10
        
        loginAnimationView = .init(name: "loading")
        loginAnimationView!.frame = centerLoading.bounds
        loginAnimationView!.contentMode = .scaleAspectFill
        loginAnimationView!.loopMode = .loop
        centerLoading.addSubview(loginAnimationView!)
        
        loginAnimationView?.isHidden = false
        loginAnimationView!.play()
    }
    
    // function to init the UI Components
    func initUIComponents() {
        // common things
        loadingView.isHidden = true
        loginSectionView.isHidden = true
        forgetButton.isHidden = true
        loadingView.isHidden = true
        emailEmpty.isHidden = true
        passwordEmpty.isHidden = true
        
        //check the var show only login
        if(showOnlyLogin == true) {
            showOnlyLoginUI()
        } else {
            showSplashUI()
        }
        
    }
    
    @IBAction func forgetAction(_ sender: UIButton) {        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            let forgetPasswordVC = ForgetPasswordVC()
            forgetPasswordVC.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            forgetPasswordVC.modalPresentationStyle = .overFullScreen //or .overFullScreen for transparency
            self.present(forgetPasswordVC, animated: true, completion: nil)
        }
    }

    
    // show only the login section
    func showOnlyLoginUI() {
        logoIamge.isHidden = true
        loginBehavior()
    }
    
    // show the splash
    func showSplashUI() {
        
        self.logoIamge.alpha = 0
        logoIamge.fadeIn(1.5)  // uses custom duration (1.0 in this example)
        
        animationView = .init(name: "loading")
        animationView!.frame = AnimatedView.bounds
        animationView!.contentMode = .scaleAspectFill
        animationView!.loopMode = .loop
        AnimatedView.addSubview(animationView!)
        
        animationView?.isHidden = true
        fixLogo.isHidden = true
        designBottom.isHidden = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.animationView?.isHidden = false
            self.animationView!.play()
        }
        
        
        // 3 seconds after the ending of animation
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            // check if the user had already activated keep online
            if(self.keepOnline) {
                // navigate to home
                self.navigateToDestination()
            } else {
                self.loginBehavior()
            }
        }
        
    }
    
    // function to get the state of variables from cache
    func getDataFromCache() {
        let defaults = UserDefaults.standard
        defaults.set(false, forKey: Constants.KEEP_ONLINE)

        faceidIsActivated = defaults.bool(forKey: Constants.FACEID_IS_ACTIVATED)
        keepOnline = defaults.bool(forKey: Constants.KEEP_ONLINE)
    }
    
    // navigate to home
    func navigateToDestination() {
 

        if(!(emailTextField.text!.isEmpty) && !(passwordTextField.text!.isEmpty)) {
            // show Loader in login section
            showLoginLoader()
            
            // save the credentiels
            UserDefaults.standard.set(emailTextField.text,forKey: Constants.USER_EMAIL)
            UserDefaults.standard.set(passwordTextField.text,forKey: Constants.USER_PWD)

            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                let mainTabBarViewController = MainTabBarViewController()
                mainTabBarViewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                mainTabBarViewController.modalPresentationStyle = .overFullScreen //or .overFullScreen for transparency
                self.present(mainTabBarViewController, animated: true, completion: nil)
            }
        } else {
            // behavior empty fiels
            showErrorFields()
        }

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

        if(!faceidIsActivated) {
            hideFaceIDIcon()
        } else {
            viewH.constant += 10
        }
        
        
    }
    
    // click on email field
    @IBAction func emailAction(_ sender: UITextField) {
        if(errorFieldEnabled == true) {
            showInitFields()
        }
    }
    
    // click on password field
    @IBAction func passwordAction(_ sender: UITextField) {
        if(errorFieldEnabled == true) {
            showInitFields()
        }
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
        // decrease the height of the mainView
        viewH.constant -= 30
        // hide teh button
        faceidButton.isHidden = true
    }
    
    // show error in login section
    func showErrorFields() {
        errorFieldEnabled = true
        
        passwordTextField.backgroundColor = UIColor(named: "error_color")
        emailTextField.backgroundColor = UIColor(named: "error_color")
        
        passwordEmpty.isHidden = false
        emailEmpty.isHidden = false
    }
    
    func showInitFields() {
        errorFieldEnabled = false
        
        passwordTextField.backgroundColor = UIColor(named: "background_color")
        emailTextField.backgroundColor = UIColor(named: "background_color")
        
        passwordEmpty.isHidden = true
        emailEmpty.isHidden = true

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
            
            self.forgetButton.isHidden = false
            self.forgetButton.alpha = 0
            self.forgetButton.fadeIn(0.5)
        }
    }


    // MARK: - FaceID Functions
    
    // function that call the Face ID service
    func checkFaceID() {
        let context = LAContext()
        var error: NSError?

        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Identify yourself!"

            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) {
                [weak self] success, authenticationError in

                DispatchQueue.main.async {
                    if success {
                        // change state of the switch
                        self!.emailTextField.text = UserDefaults.standard.string(forKey: Constants.USER_EMAIL)
                        self!.passwordTextField.text = UserDefaults.standard.string(forKey: Constants.USER_PWD)
                        self?.navigateToDestination()

                    } else {
                        // change state of the switch
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
