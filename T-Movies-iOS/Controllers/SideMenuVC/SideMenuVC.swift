//
//  SideMenuVC.swift
//  T-Movies-iOS
//
//  Created by Taha JADID on 6/3/2023.
//

import UIKit

class SideMenuVC: UIViewController {

    var menuList: [MenuOptionItem] = Constants.menuList
    var delegate: MenuDelegate?
    private let reuseIdentifier = "SideMenuCell"

    @IBOutlet weak var logoutView: UIView!
    @IBOutlet weak var rightView: UIView!

    @IBOutlet weak var menuOptionTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureMenuTable()
        configureUI()

    }
    
    // Hide navigationBar on the Top
    override func viewWillAppear(_ animated: Bool) {
        self.rightView.alpha = 0
        rightView.fadeIn(0.5)  // uses custom duration (1.0 in this example)
        
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    func configureMenuTable(){
        menuOptionTableView.dataSource = self
        menuOptionTableView.delegate = self
        let nib = UINib(nibName: reuseIdentifier, bundle: nil)
        menuOptionTableView.register(nib, forCellReuseIdentifier: reuseIdentifier)
    }
    
    func configureUI() {
        logoutView.cornerRadius = 8
        
        let gestureHide = UITapGestureRecognizer(target: self, action:  #selector (self.hideMenuOnTap (_:)))
        rightView.addGestureRecognizer(gestureHide)
        
        let gestureLogout = UITapGestureRecognizer(target: self, action:  #selector (self.logoutAction (_:)))
        logoutView.addGestureRecognizer(gestureLogout)
        
        let gestureSwipe = UISwipeGestureRecognizer(target: self, action:  #selector (self.hideMenuOnSwipe (_:)))
        gestureSwipe.direction = .left
        rightView.addGestureRecognizer(gestureSwipe)

    }


    @objc func logoutAction(_ sender:UITapGestureRecognizer){
        let splashVC = SplashVC()
        splashVC.showOnlyLogin = true
        splashVC.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        splashVC.modalPresentationStyle = .overFullScreen //or .overFullScreen for transparency
        self.present(splashVC, animated: true, completion: nil)
    }
    
    
    @objc func hideMenuOnTap(_ sender:UITapGestureRecognizer){
        rightView.fadeOut(0.2)  // uses custom duration (1.0 in this example)
        
        // do other task
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = CATransitionType.moveIn
        transition.subtype = CATransitionSubtype.fromRight
        view.window!.layer.add(transition, forKey: kCATransition)
        self.dismiss(animated: false)
        
    }
    
    @objc func hideMenuOnSwipe(_ sender: UISwipeGestureRecognizer){
        // do other task
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        view.window!.layer.add(transition, forKey: kCATransition)
        self.dismiss(animated: false)
        
    }
    
}

extension SideMenuVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! SideMenuCell
        cell.menuTitle.text = self.menuList[indexPath.row].title
        cell.menuIconImage.image = UIImage(named: self.menuList[indexPath.row].image ?? "settings")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("click on ",self.menuList[indexPath.row])
        delegate?.handleMenuToggle(forMenuOptiom: self.menuList[indexPath.row])
        self.setSelectedItem(self.menuList[indexPath.row])
        self.menuOptionTableView.reloadData()
    }
    
    func setSelectedItem(_ menuOptionItem: MenuOptionItem) {

        switch (menuOptionItem.title) {
            case "Home" :
                navigateToHome()
            
            case "Favourite" :
                navigateToFavourite()
                
            case "Settings" :
                navigateToSetting()
                
            default :
                navigateToHome()
        }
        

        for item in self.menuList {
            if(menuOptionItem.id == item.id){
                self.menuList[item.id!].isSelected = true
            }else {
                self.menuList[item.id!].isSelected = false
            }
        }
    }
    
    func navigateToHome() {
        let homeVC = MainTabBarViewController()
        homeVC.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        homeVC.modalPresentationStyle = .overFullScreen //or .overFullScreen for transparency
        self.present(homeVC,animated: false,completion: nil)
    }
    
    func navigateToSetting() {
        let settingVC = SettingVC()
        //settingVC.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        //settingVC.modalPresentationStyle = .overFullScreen //or .overFullScreen for transparency
        self.present(settingVC,animated: true,completion: nil)
    }
    
    func navigateToFavourite() {
        let homeVC = MainTabBarViewController()
        homeVC.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        homeVC.modalPresentationStyle = .overFullScreen //or .overFullScreen for transparency
        self.present(homeVC,animated: false,completion: nil)
    }
    
    
}

extension ViewController: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PresentTransition()
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return DismissTransition()
    }
}
