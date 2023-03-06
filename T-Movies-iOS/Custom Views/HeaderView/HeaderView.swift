//
//  HeaderView.swift
//  T-Movies-iOS
//
//  Created by Taha JADID on 28/2/2023.
//

import UIKit

class HeaderView: UIView {
  
    var view: UIView!

    var delegate: MenuDelegate?

    
    @IBOutlet weak var menuButton: UIButton!
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initXibView()
    }
  
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.initXibView()
    }
    
    func initXibView() {
        view = loadNib()
        
        // use bounds not frame or it'll be offset
        view.frame = bounds
        // Adding custom subview on top of our view (over any custom drawing > see note below)
        view.fixConstraintsToView(self, positionType: .margin, top: 0, right: 0, bottom: 0, left: 0)
    }
    
    /*
     This function is used to load the nib of the view (custom View)
     */
    func loadNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nibName = type(of: self).description().components(separatedBy: ".").last!
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView ?? UIView()
    }
    
    @IBAction func clickMenuButton(_ sender: UIButton) {


        
        if var topController = UIApplication.shared.keyWindow?.rootViewController  {
              while let presentedViewController = topController.presentedViewController {
                    topController = presentedViewController
                   }
            
            /*
            let sideMenuVC = SideMenuVC()
            sideMenuVC.modalPresentationStyle = .overFullScreen
            //sideMenuVC.transitioningDelegate = self

            topController.present(sideMenuVC, animated: false, completion: nil)

             */
            
            let sideMenuVC = SideMenuVC()
            sideMenuVC.modalPresentationStyle = .overFullScreen

            let transition = CATransition()
            transition.duration = 0.3
            transition.type = CATransitionType.push
            transition.subtype = CATransitionSubtype.fromLeft
            view.window!.layer.add(transition, forKey: kCATransition)
            topController.present(sideMenuVC, animated: false, completion: nil)
        }
    }

    
  
}

extension HeaderView: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PresentTransition()
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return DismissTransition()
    }
}
