//
//  TabBarViewController.swift
//  CrimeShield
//
//  Created by Brenna Pavlinchak on 1/29/25.
//

import UIKit

class TabBarViewController: UITabBarController
{
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Create view controllers for each tab
        let homeViewController = HomeViewController()
        let createViewController = CreateViewController()
        let sentReportsViewController = SentReportsViewController()
        let mapViewController = MapViewController()
        let settingsViewController = SettingsViewController()

        // Create a UITabBarController
        let tabBarController = UITabBarController()

        // Set the view controllers for each tab
        tabBarController.viewControllers = [homeViewController, createViewController, sentReportsViewController, mapViewController, settingsViewController]

        // Customize tab bar items
        homeViewController.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))

        createViewController.tabBarItem = UITabBarItem(title: "Create", image: UIImage(systemName: "create"), selectedImage: UIImage(systemName: "clipboard.fill"))
        
        sentReportsViewController.tabBarItem = UITabBarItem(title: "Reports", image: UIImage(systemName: "report"), selectedImage: UIImage(systemName: "folder.fill"))

        mapViewController.tabBarItem = UITabBarItem(title: "Map", image: UIImage(systemName: "map"), selectedImage: UIImage(systemName: "map.fill"))
        
        settingsViewController.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "settings"), selectedImage: UIImage(systemName: "gear"))
    }
}
