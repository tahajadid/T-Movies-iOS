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
    
    @IBOutlet weak var descriptionValue: UILabel!
    
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var ratingPeople: UILabel!
    @IBOutlet weak var prodDate: UILabel!

    @IBOutlet weak var heightViewBottom: NSLayoutConstraint!
    @IBOutlet weak var heightViewParent: NSLayoutConstraint!
    
    @IBOutlet weak var adultValue: UILabel!
    @IBOutlet weak var adultBg: UIView!
    
    var movieInfo: Result!
    
    var isFavourite = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        addRadiusToBg()
        
        fillInformation()

        addRadiusBlur()
        
        
        let gestureSwipe = UISwipeGestureRecognizer(target: self, action:  #selector (self.dimissAll (_:)))
        gestureSwipe.direction = .right
        self.view.addGestureRecognizer(gestureSwipe)

    }
    
    
    @objc func dimissAll(_ sender: UISwipeGestureRecognizer){
        navigationController?.popViewController(animated: true)
    }
    
    // Hide navigationBar on the Top
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        self.tabBarController?.tabBar.isHidden = true
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
        
        descriptionValue.text = movieInfo.overview
        
        rating.text = String(Double(round(10 * Double(movieInfo.voteAverage)) / 10))

        prodDate.text = movieInfo.releaseDate
        
        setAdultView()
        adaptTitleSize()
    }
    
    
    func setImage(_ pathWallpapaer: String){
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(pathWallpapaer)") else {
            return
        }
        moviePoster.sd_setImage(with: url, completed: { _,_,_,_ in
            self.spinner.stopAnimating()
            self.spinner.isHidden = true
        })
        
        blurUIImageView.sd_setImage(with: url, completed: nil)
    }
    
    func setAdultView() {
        adultBg.layer.cornerRadius = 4
        if(movieInfo.adult) {
            adultBg.backgroundColor = .red
            adultValue.text = "+18"
            adultValue.textColor = .black
        }
    }
    
    // adapt size view depending on the title size
    func adaptTitleSize() {
        titleMovie.text = movieInfo.title
        print(movieInfo.title.count)

        if(movieInfo.title.count < 22){
            // don't do anything
        } else if(movieInfo.title.count < 44 && movieInfo.title.count > 21) {
            // 2 lines in the title
            heightViewParent.constant  = 640
            heightViewBottom.constant = 140
            
        } else if(movieInfo.title.count > 43 ){
            // 3 lines in the title
            heightViewParent.constant  = 670
            heightViewBottom.constant = 170
        }

    }
    
}
