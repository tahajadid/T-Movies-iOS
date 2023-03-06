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

        
        let gestureHide = UITapGestureRecognizer(target: self, action:  #selector (self.hideSideMenu (_:)))
        rightView.addGestureRecognizer(gestureHide)
        
        let gestureSwipe = UISwipeGestureRecognizer(target: self, action:  #selector (self.hideSwipe (_:)))
        gestureSwipe.direction = .left
        rightView.addGestureRecognizer(gestureSwipe)
        

        logoutView.cornerRadius = 12
        //rightView.fadeIn(2.0)  // uses custom duration (1.0 in this example)

        //rightView.fadeIn(duration: 1.5)
        
        // Do any additional setup after loading the view.
    }
    
    // Hide navigationBar on the Top
    override func viewWillAppear(_ animated: Bool) {
        rightView.fadeIn(2.0)  // uses custom duration (1.0 in this example)

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


    @objc func hideSideMenu(_ sender:UITapGestureRecognizer){
        // do other task
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = CATransitionType.moveIn
        transition.subtype = CATransitionSubtype.fromRight
        view.window!.layer.add(transition, forKey: kCATransition)
        self.dismiss(animated: false)
        
        //dismiss(animated: true, completion: nil)

    }
    
    @objc func hideSwipe(_ sender: UISwipeGestureRecognizer){
        // do other task
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        view.window!.layer.add(transition, forKey: kCATransition)
        self.dismiss(animated: false)
        
        //dismiss(animated: true, completion: nil)

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
        for item in self.menuList {
            if(menuOptionItem.id == item.id){
                self.menuList[item.id!].isSelected = true
            }else {
                self.menuList[item.id!].isSelected = false
            }
            
        }
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
