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

        
        let vc1 = UINavigationController(rootViewController: HomeVC())
        let vc2 = UINavigationController(rootViewController: SearchVC())
        let vc3 = UINavigationController(rootViewController: ProfileVC())

        
        vc1.tabBarItem.image = UIImage(named: "Squircle")
        vc2.tabBarItem.image = UIImage(systemName: "magnifyingglass.circle")
        vc3.tabBarItem.image = UIImage(systemName: "person")

        vc1.tabBarItem.selectedImage = UIImage(named: "Subtract")
        vc2.tabBarItem.selectedImage = UIImage(systemName: "magnifyingglass.circle.fill")
        vc3.tabBarItem.selectedImage = UIImage(systemName: "person.fill")
        

        vc1.title = "Home"
        vc2.title = "Search"
        vc3.title = "Profile"
        
        tabBar.tintColor = UIColor(named: "primary_color")
        tabBar.unselectedItemTintColor = UIColor.init(named: "label_color")
        UITabBar.appearance().barTintColor = UIColor(named: "background_color")
        //tabBar.isTranslucent = false

        setViewControllers([vc1,vc2,vc3], animated: true)

    }
    

}
