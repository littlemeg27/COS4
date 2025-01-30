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
        
        // Get the storyboard instance
        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        // Create view controllers for each tab
        // Instantiate view controllers using Storyboard IDs
        let homeViewController = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        let createViewController = storyboard.instantiateViewController(withIdentifier: "CreateViewController") as! CreateViewController
        let sentReportsViewController = storyboard.instantiateViewController(withIdentifier: "SentReportsViewController") as! SentReportsViewController
        let mapViewController = storyboard.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
        let settingsViewController = storyboard.instantiateViewController(withIdentifier: "SettingsViewController") as! SettingsViewController

        // Assign view controllers to the tab bar
        self.viewControllers = [homeViewController, createViewController, sentReportsViewController, mapViewController, settingsViewController]

        // Customize tab bar items with valid SF Symbols
        homeViewController.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
        createViewController.tabBarItem = UITabBarItem(title: "Create", image: UIImage(systemName: "square.and.pencil"), selectedImage: UIImage(systemName: "square.and.pencil.fill"))
        sentReportsViewController.tabBarItem = UITabBarItem(title: "Reports", image: UIImage(systemName: "doc.text"), selectedImage: UIImage(systemName: "doc.text.fill"))
        mapViewController.tabBarItem = UITabBarItem(title: "Map", image: UIImage(systemName: "map"), selectedImage: UIImage(systemName: "map.fill"))
        settingsViewController.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "gearshape"), selectedImage: UIImage(systemName: "gearshape.fill"))
    }
}
