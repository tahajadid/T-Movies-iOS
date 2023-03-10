//
//  ProfileVC.swift
//  T-Movies-iOS
//
//  Created by Taha JADID on 28/2/2023.
//

import UIKit
import LocalAuthentication

class ProfileVC: UIViewController {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var profileImageBg: UIImageView!
    @IBOutlet weak var switchFaceid: UISwitch!
    @IBOutlet weak var editView: UIView!
        
    @IBOutlet weak var lineOne: UIView!
    @IBOutlet weak var lineTwo: UIView!
    
    @IBOutlet weak var emailValue: UILabel!
    
    var emailEnabled = false
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
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
    
    //Calls this function when the tap is recognized.
    @objc override func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    @IBAction func clickOnEdit(_ sender: UIButton) {
        // Create the alert controller.
        let alert = UIAlertController(title: "Email Adress Title", message: "Change your current email adress", preferredStyle: .alert)

        // Add the text field. You can configure it however you need.
        alert.addTextField { (textField) in
            textField.text = self.emailValue.text
        }

        // Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "Confirm", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0] // Force unwrapping because we know it exists.
            self.emailValue.text = textField?.text
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive , handler: { [weak alert] (_) in
            // do nothing
        }))
        
        // Present the alert.
        self.present(alert, animated: true, completion: nil)

    }
    
    func configureUI() {
        profileImage.layer.masksToBounds = false
        profileImage.layer.cornerRadius = profileImage.frame.height/2
        profileImage.clipsToBounds = true
        
        profileImageBg.layer.masksToBounds = false
        profileImageBg.layer.cornerRadius = profileImageBg.frame.height/2
        profileImageBg.clipsToBounds = true
        
        editView.layer.masksToBounds = false
        editView.layer.cornerRadius = editView.frame.height/2
        editView.clipsToBounds = true
        
        lineOne.layer.cornerRadius = 4
        lineTwo.layer.cornerRadius = 4


        switchFaceid.addTarget(self, action: #selector(stateChangedSwitch), for: .valueChanged)
        
    }
    
    @objc func stateChangedSwitch(switchState: UISwitch) {
       if switchFaceid.isOn {
           checkFaceID(false)
       } else {
           checkFaceID(true)
       }
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
                        self?.switchFaceid.setOn(!actualValue, animated: true)

                    } else {
                        // change state of the switch
                        self?.switchFaceid.setOn(actualValue, animated: true)
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
