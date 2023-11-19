//
//  MainTabBarViewController.swift
//  spaceInfo
//
//  Created by Saba Gogrichiani on 19.11.23.
//

import UIKit

final class MainTabBarViewController: UITabBarController {
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTabBarViews()
    }
    
    // MARK: - Setup Methods
    private func setUpTabBarViews() {
        let homeVC = createHomeVC()
        let breedVC = breedVC()
        
        setViewControllers([homeVC, breedVC], animated: true)
    }
    
    // MARK: - Helper Methods
    private func createHomeVC() -> UINavigationController {
        let homeVC = UINavigationController(rootViewController: MainPageViewController())
        homeVC.tabBarItem.image = UIImage(systemName: "list.dash")
        return homeVC
    }
    
    private func breedVC() -> UINavigationController {
        let breedVC = UINavigationController(rootViewController: BreedViewController())
        breedVC.tabBarItem.image = UIImage(systemName: "cat")
        breedVC.title = "Breeds"
        return breedVC
    }
}
