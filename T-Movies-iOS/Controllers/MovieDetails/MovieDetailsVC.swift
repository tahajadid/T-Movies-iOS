//
//  MovieDetailsVC.swift
//  T-Movies-iOS
//
//  Created by Taha JADID on 1/3/2023.
//

import UIKit

class MovieDetailsVC: UIViewController {
    
    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var favouriteButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var blurUIView: UIView!
    
    var isFavourite = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //view.insetsLayoutMarginsFromSafeArea = false
        
        addRadiusBlur()
        
    }
    
    // Hide navigationBar on the Top
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func addRadiusBlur() {
        self.blurUIView.clipsToBounds = true
        self.blurUIView.layer.cornerRadius = 20
        self.blurUIView.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
        
        let blurredView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
        blurredView.frame = self.view.bounds
        blurUIView.addSubview(blurredView)
    }
    

    @IBAction func favouriteClick(_ sender: UIButton) {
        if(isFavourite){
            favouriteButton.setImage(UIImage(named: "heart_button"), for: .normal)
        }else{
            favouriteButton.setImage(UIImage(named: "heart_on_button"), for: .normal)
        }
        isFavourite = !isFavourite
    }
    
    @IBAction func backaClick(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}
