//
//  UIViewControllerExtension.swift
//  T-Movies-iOS
//
//  Created by Taha JADID on 1/3/2023.
//

import UIKit

extension UIViewController {
    /*
     func for hiding keyboad after tapping arround
     */
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    /*
     Show alert in View Controller
     */
    public func showAlert(title: String?,
                          message: String?,
                          icon: String = String(),
                          actionTitles: [String?],
                          style: [UIAlertAction.Style],
                          actions: [((UIAlertAction) -> Void)?],
                          preferredActionIndex: Int? = nil) {
        let imageView = UIImageView(frame: CGRect(x: 5, y: 5, width: 25, height: 25))
        imageView.image = UIImage(named: icon)
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.view.addSubview(imageView)
        for (index, title) in actionTitles.enumerated() {
            let action = UIAlertAction(title: title, style: style[index], handler: actions[index])
            alert.addAction(action)
        }
        if let preferredActionIndex = preferredActionIndex {
            alert.preferredAction = alert.actions[preferredActionIndex]
        }
        self.present(alert, animated: true, completion: nil)
    }
}
