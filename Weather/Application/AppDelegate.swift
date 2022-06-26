//
//  AppDelegate.swift
//  Weather
//
//  Created by Евгений Мизюк on 30.05.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let firstViewController = MainCityViewController()
        firstViewController.title = "Погода"
        let secondViewConrtoller = CityViewController()
        secondViewConrtoller.title = "Город"
        secondViewConrtoller.delegate = firstViewController
        
        let navController = UINavigationController(rootViewController: secondViewConrtoller)
        
        let tabBarViewConrtoller = UITabBarController()
        tabBarViewConrtoller.setViewControllers([firstViewController, navController], animated: true)
        if firstViewController.checkViewModelObjectForNil() == nil {
            tabBarViewConrtoller.selectedIndex = 1
//            tabBarViewConrtoller.tabBar.isHidden = true
        } else {
            tabBarViewConrtoller.selectedIndex = 0
        }
        
        self.window = UIWindow()
        self.window?.rootViewController = tabBarViewConrtoller
        self.window?.makeKeyAndVisible()
        
        return true
    }

}
