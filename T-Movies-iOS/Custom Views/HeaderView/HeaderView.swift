//
//  HeaderView.swift
//  T-Movies-iOS
//
//  Created by Taha JADID on 28/2/2023.
//

import UIKit

class HeaderView: UIView {
  
    var view: UIView!

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
    
  
}
