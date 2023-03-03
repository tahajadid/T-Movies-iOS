//
//  MovieDetailsVC.swift
//  T-Movies-iOS
//
//  Created by Taha JADID on 1/3/2023.
//

import UIKit
import SDWebImage

class MovieDetailsVC: UIViewController {
    
    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var favouriteButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var blurUIView: UIView!
    @IBOutlet weak var blurUIImageView: UIImageView!

    @IBOutlet weak var categorieBg: UIView!
    @IBOutlet weak var categorieMovie: UILabel!
    
    @IBOutlet weak var titleMovie: UILabel!
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    var movieInfo: Result!
    
    var isFavourite = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //view.insetsLayoutMarginsFromSafeArea = false
        
        addRadiusToBg()
        
        fillInformation()
        
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
    
    func addRadiusToBg() {
        self.categorieBg.layer.cornerRadius = 6
    }
    
    func fillInformation() {
        spinner.layer.cornerRadius = 8
        spinner.startAnimating()
        
        setImage(movieInfo.posterPath)
        titleMovie.text = movieInfo.title
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
    
    func setImage(_ pathWallpapaer: String){
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(pathWallpapaer)") else {
            return
        }
        moviePoster.sd_setImage(with: url, completed: { _,_,_,_ in
            self.spinner.stopAnimating()
            self.spinner.isHidden = true
        })
        
        moviePoster.sd_setImage(with: url, completed: { _,_,_,_ in
            self.spinner.stopAnimating()
            self.spinner.isHidden = true
        })
        
        blurUIImageView.sd_setImage(with: url, completed: nil)
    }
    
    
}
