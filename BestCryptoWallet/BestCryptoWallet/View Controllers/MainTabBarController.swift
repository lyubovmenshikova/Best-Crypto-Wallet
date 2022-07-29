//
//  MainTabBarController.swift
//  BestCryptoWallet
//
//  Created by Lyubov Menshikova on 28.07.2022.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTabBarAppearence()
        setViewControllers()
    }
    
    private func setUpTabBarAppearence() {
        if #available(iOS 15.0, *) {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            
            //color for tabBar Icon
            appearance.stackedLayoutAppearance.normal.iconColor = UIColor(red: 53/255, green: 212/255, blue: 184/255, alpha: 1)
            appearance.stackedLayoutAppearance.selected.iconColor = UIColor(red: 53/255, green: 212/255, blue: 184/255, alpha: 1)

            tabBar.standardAppearance = appearance
            tabBar.scrollEdgeAppearance = tabBar.standardAppearance
        }
        
    }
   
    private func setViewControllers() {
        let coinsTableViewController =  CoinsViewController()
        let profileViewController = ProfileViewController()
        
        coinsTableViewController.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "list.bullet.rectangle.portrait"), selectedImage: UIImage(systemName: "list.bullet.rectangle.portrait.fill"))

        profileViewController.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "person"), selectedImage: UIImage(systemName: "person.fill"))
        
        viewControllers = [coinsTableViewController, profileViewController]
    }

}
