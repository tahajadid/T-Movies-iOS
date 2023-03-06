//
//  UIViewExtension.swift
//  T-Movies-iOS
//
//  Created by Taha JADID on 28/2/2023.
//

import UIKit
/*
 This class is extension of UIView
 */

public extension UIView {

    func fadeTo(_ alpha: CGFloat, duration: TimeInterval = 0.3) {
      DispatchQueue.main.async {
        UIView.animate(withDuration: duration) {
          self.alpha = alpha
        }
      }
    }
    
    func fadeIn(_ duration: TimeInterval = 0.5) {
      fadeTo(1.0, duration: duration)
    }

    func fadeOut(_ duration: TimeInterval = 0.5) {
      fadeTo(0.0, duration: duration)
    }

}
extension UIView {
    /*
     New Inspectable for Setting CornerRadius
     */
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue
            self.addCornerRadiusWith(width: newValue)
            // todo: in case ripple on
            mkLayer.superLayerDidResize()
        }
    }
    
    
    /*
     This Function Can add Corner Radius to uiview
     */
    func addCornerRadiusWith(width: CGFloat) {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = width
    }
    /*
     This Function make uiview circular
     */
    func makeCircular() {
        addCornerRadiusWith(width: self.frame.size.height/2.0)
    }
    /*
     This Function make uiview rounded with specific border width and color
     */
    func makeRoundedWith(borderWidth: CGFloat, borderColor: UIColor) {
        self.layer.borderWidth = borderWidth
        self.layer.masksToBounds = false
        self.layer.borderColor = borderColor.cgColor
        self.layer.cornerRadius = self.frame.height / 2
        self.clipsToBounds = true
    }
    /*
     This Fuction Add border to view with specific width, color, and cornerRadius
     */
    func addBorderWith(width: CGFloat, color: UIColor, cornerRadius: CGFloat) {
        self.layer.borderWidth = width
        self.layer.borderColor = color.cgColor
        self.layer.cornerRadius = cornerRadius
    }
    
    /*
     This funtion is for drop shadow in view
     */
    func dropShadow(isWhiteBg: Bool = true, corner: Int = 10) {
        self.backgroundColor = isWhiteBg ? .white : .clear
        self.clipsToBounds = false
        self.layer.masksToBounds = false
        self.layer.shadowRadius = CGFloat(corner)
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 0, height: 5)
        self.layer.cornerRadius = CGFloat(corner)
    }
    func setShadow() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.3
        self.layer.shadowOffset = .zero
        self.layer.shadowRadius = 4
    }

    /*
     This Fuction to set a click handler sending the target to manage the click and its action
     */
    func setOnClickListener(target: Any?, action: Selector) {
        let gesture = UITapGestureRecognizer(target: target, action: action)
        gesture.numberOfTapsRequired = 1
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(gesture)
    }
    /*
     Make some corners radius
     */
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        var corner: CACornerMask = CACornerMask()
        if corners.contains(.topLeft) {
            corner.insert(.layerMinXMinYCorner)
        }
        if corners.contains(.topRight) {
            corner.insert(.layerMaxXMinYCorner)
        }
        if corners.contains(.bottomLeft) {
            corner.insert(.layerMinXMaxYCorner)
        }
        if corners.contains(.bottomRight) {
            corner.insert(.layerMaxXMaxYCorner)
        }
        self.layer.cornerRadius = radius
        self.layer.maskedCorners = corner
    }
    /*
     This function is to remove subViews
     */
    func removeSubViews() {
        self.subviews.forEach { mView in
            mView.removeFromSuperview()
            mView.removeSubViews()
        }
    }
    /*
     This Fuction to used to add a view to its parent view using constraints programmatically
     */
    func fixConstraintsToView(_ container: UIView, positionType: ViewPostion, top: CGFloat?, right: CGFloat?, bottom: CGFloat?, left: CGFloat?) {
        container.addSubview(self)
        self.translatesAutoresizingMaskIntoConstraints = false
        
        switch positionType {
        case .margin:
            if top != nil {
                let const = NSLayoutConstraint(item: self,
                                   attribute: .top,
                                   relatedBy: .equal,
                                   toItem: container,
                                   attribute: .top,
                                   multiplier: 1.0,
                                   constant: top!)
                const.identifier = "topAnchorConst"
                const.isActive = true
            }
            
            if right != nil {
                let const = NSLayoutConstraint(item: self,
                                               attribute: .trailing,
                                               relatedBy: .equal,
                                               toItem: container,
                                               attribute: .trailing,
                                               multiplier: 1.0,
                                               constant: right! * -1)
                const.identifier = "rightAnchorConst"
                const.isActive = true
            }
            
            if bottom != nil {
                let const = NSLayoutConstraint(item: self,
                                   attribute: .bottom,
                                   relatedBy: .equal,
                                   toItem: container,
                                   attribute: .bottom,
                                   multiplier: 1.0,
                                   constant: bottom! * -1)
                const.identifier = "bottomAnchorConst"
                const.isActive = true
            }
            
            if left != nil {
                let const = NSLayoutConstraint(item: self,
                                   attribute: .leading,
                                   relatedBy: .equal,
                                   toItem: container,
                                   attribute: .leading,
                                   multiplier: 1.0,
                                   constant: left!)
                const.identifier = "leftAnchorConst"
                const.isActive = true
            }
        }
    }
    
    /*
     This function to remove a view a parent view
     */
    func removeSubViewWithTag(view: UIView? = nil, tag: Int) {
        _ = self.subviews.map { (value) in
            if value.tag == tag {
                value.removeFromSuperview()
            }
        }
    }
    
    /*
     This function to turn the view into monochrome colors
     */
    func convertColorsToMonochrome() {
        removeMonoChromeLayer()
        let grayLayer = CALayer()
        let width = UIScreen.main.bounds.width
        print("cell width : \(width)")
        grayLayer.frame = CGRect(x: 0, y: 0, width: width, height: bounds.height)
        // grayLayer.masksToBounds = true
        grayLayer.compositingFilter = "colorBlendMode"
        grayLayer.backgroundColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1.0).cgColor
        // layer.addSublayer(grayLayer)
        self.layer.addSublayer(grayLayer)
    }
    
    /*
     This function to remove the monochrome layers
     */
    func removeMonoChromeLayer() {
        _ = self.layer.sublayers.map({$0.map { lay in
            if let nameLayer = lay.compositingFilter as? String, nameLayer == "colorBlendMode" {
                lay.removeFromSuperlayer()
            }
        }})
    }
    
    /*
     This function to get position of CGRect to last superView ( globally )
     */
    func getPositionGloballyScreen() -> CGRect {
        if let superView = self.superview {
            let posItem = superView.convert(self.frame.origin, to: nil)
            let finalY = posItem.y
            let frame = CGRect(x: posItem.x,
                               y: finalY,
                               width: self.frame.width,
                               height: self.frame.height)
            return frame
        }
        return .zero
    }
    
    /*
     This function to get position of PosY to last superView ( globally )
     */
    func getPositionVerticalGloballyScreen(mView: UIView) -> CGFloat {
        if let superView = mView.superview {
            let posItem = superView.convert(mView.frame.origin, to: nil)
            return posItem.y + getPositionVerticalGloballyScreen(mView: superView)
        }
        return 0
    }
    
}
/*
    Array Extension
 */
extension Array {
    mutating func move(from oldIndex: Index, to newIndex: Index) {
        /*
            Change indexes of array
         */
        if oldIndex == newIndex { return }
        if abs(newIndex - oldIndex) == 1 { return self.swapAt(oldIndex, newIndex) }
        self.insert(self.remove(at: oldIndex), at: newIndex)
    }
}
/*
 This enum is used to set the view's location using the function on this file "fixConstraintsToView(..)"
 */
enum ViewPostion {
    case margin
}

extension UIView {

    // Using a function since `var image` might conflict with an existing variable
    // (like on `UIImageView`)
    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}

/*
 This extension to add actions to UIStackView
 */
extension UIStackView {
    /*
     This function is to remove subViews
     */
    func removeArrangedSubViews() {
        self.arrangedSubviews.forEach { mView in
            self.removeArrangedSubview(mView)
        }
    }
}
private var initialMkLayerKey: Int = 0
/*
 Ripple Effect
 */
extension UIView {
    
    /*
     Ripple's Effect
     */
    @IBInspectable open var maskEnabled: Bool {
        get {
            return mkLayer.maskEnabled
        }
        set {
            mkLayer.maskEnabled = newValue
            mkLayer.superLayerDidResize()
        }
    }
    
    @IBInspectable open var elevation: CGFloat {
        get {
            return mkLayer.elevation
        }
        set {
            mkLayer.elevation = newValue
        }
    }
    @IBInspectable open var shadowOffset: CGSize {
        get {
            return mkLayer.shadowOffset
        }
        set {
            mkLayer.shadowOffset = newValue
        }
    }
    
    var roundingCorners: UIRectCorner {
        get {
            return mkLayer.roundingCorners
        }
        set {
            mkLayer.roundingCorners = newValue
        }
    }
    
    @IBInspectable open var rippleEnabled: Bool {
        get {
            return mkLayer.rippleEnabled
        }
        set {
            mkLayer.rippleEnabled = newValue
        }
    }
    var rippleDuration: CFTimeInterval {
        get {
            return mkLayer.rippleDuration
        }
        set {
            mkLayer.rippleDuration = newValue
        }
    }
    @IBInspectable open var rippleScaleRatio: CGFloat {
        get {
            return mkLayer.rippleScaleRatio
        }
        set {
            mkLayer.rippleScaleRatio = newValue
        }
    }
    @IBInspectable open var rippleLayerColor: UIColor {
        get {
            return mkLayer.rippleLayerColor
        }
        set {
            mkLayer.setRippleColor(color: newValue)
        }
    }
    @IBInspectable open var backgroundAnimationEnabled: Bool {
        get {
            return mkLayer.backgroundAnimationEnabled
        }
        set {
            mkLayer.backgroundAnimationEnabled = newValue
        }
    }
    
    var mkLayer: MKLayer {
        get {
            if let mLayer = objc_getAssociatedObject(self, &initialMkLayerKey) as? MKLayer {
                return mLayer
            }
            return MKLayer(withView: UIView())
        }
        set {
            objc_setAssociatedObject(self, &initialMkLayerKey, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
    

    
    /*
     This function will add ripple effect to uiButton
     
    func addRippleEffect(color: UIColor = .gray) {
        self.mkLayer = MKLayer(withView: self)
        self.mkLayer.cornerRadius = self.cornerRadius
        self.mkLayer.isRippleActive = true
        self.maskEnabled = true
        self.rippleLayerColor = color
    }
     */
    func didTapOnRippleView(point: CGPoint) {
        guard self.mkLayer.isRippleActive else {
            return
        }
        self.mkLayer.forceStartEffectAtPos(location: point)
    }
    
    // MARK: Touch
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        mkLayer.touchesBegan(touches: touches, withEvent: event)
    }
    
    open override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        mkLayer.touchesEnded(touches: touches, withEvent: event)
    }
    
    open override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        mkLayer.touchesCancelled(touches: touches, withEvent: event)
    }
    
    open override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        mkLayer.touchesMoved(touches: touches, withEvent: event)
    }
    
    
}
