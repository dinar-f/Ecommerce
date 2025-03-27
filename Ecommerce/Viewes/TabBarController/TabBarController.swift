//
//  TabBarController.swift
//  Ecommerce
//
//  Created by Dinar on 19.03.2025.
//

import UIKit

enum Tabs: Int {
    case home
    case cart
}

final class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
    
    private func setupTabBar() {
        let homeViewController = HomeModuleBuilder.build()
        let cartViewController = HomeModuleBuilder.build()
        
        homeViewController.tabBarItem = UITabBarItem(title: nil,
                                                     image: R.Images.TabBar.home,
                                                     tag: Tabs.home.rawValue)
        cartViewController.tabBarItem = UITabBarItem(title: nil,
                                                     image: R.Images.TabBar.cart,
                                                     tag: Tabs.cart.rawValue)
        
        viewControllers = [homeViewController, cartViewController]
    }
}
