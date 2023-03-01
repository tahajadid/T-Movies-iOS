//
//  MainTabBarController.swift
//  T-Movies-iOS
//
//  Created by Taha JADID on 28/2/2023.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationController?.hidesBarsOnTap = true

        view.backgroundColor = .white
        
        let vc1 = UINavigationController(rootViewController: HomeVC())
        let vc2 = UINavigationController(rootViewController: ProfileVC())
        let vc3 = UINavigationController(rootViewController: HomeVC())

        
        vc1.tabBarItem.image = UIImage(named: "Squircle")
        vc2.tabBarItem.image = UIImage(systemName: "magnifyingglass.circle")
        vc3.tabBarItem.image = UIImage(systemName: "person")

        vc1.tabBarItem.selectedImage = UIImage(named: "Subtract")
        vc2.tabBarItem.selectedImage = UIImage(systemName: "magnifyingglass.circle.fill")
        vc3.tabBarItem.selectedImage = UIImage(systemName: "person.fill")
        

        vc1.title = "Home"
        vc2.title = "Coming"
        vc3.title = "Other"
        
        tabBar.tintColor = UIColor(named: "primary_color")
        tabBar.unselectedItemTintColor = UIColor.init(named: "label_color")

        setViewControllers([vc1,vc2,vc3], animated: true)

    }
    

}
