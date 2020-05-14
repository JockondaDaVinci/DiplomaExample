//
//  TabViewController.swift
//  OrgTech
//
//  Created by Maksym Balukhtin on 16.02.2020.
//  Copyright © 2020 Maksym Balukhtin. All rights reserved.
//

import UIKit

protocol TabRepresentile {
  var relatedTabBarItem: UITabBarItem? { get set }
}

protocol TabPresenterToView: AnyObject {
  func setupInitialState()
}

final class TabViewController: UITabBarController {
  var presenter: TabViewToPresenter?
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    presenter?.onViewAppeared()
  }
}

extension TabViewController: TabPresenterToView {
  func setupInitialState() {
    let homeView = HomePageBuilder.create().view
    let menuView = MenuBuilder.create().view
    let cartView = CartBuilder.create().view
    let searchView = SearchBuilder.create().view
    
    viewControllers = [homeView, menuView, cartView, searchView].map { UINavigationController(rootViewController: $0.viewController) }
    viewControllers?.forEach {
      guard let tabVC = $0.children.first as? TabRepresentile else { return }
      $0.tabBarItem = tabVC.relatedTabBarItem
    }
    tabBar.unselectedItemTintColor = AppDefaults.Colors.PageIndicator.default
    tabBar.tintColor = AppDefaults.Colors.PageIndicator.current
    startCartObserver()
  }
}

private extension TabViewController {
  func startCartObserver() {
    let nc = NotificationCenter.default
    nc.addObserver(self, selector: #selector(observeValue(_:)), name: .itemAddedToCart, object: nil)
  }
  
  @objc func observeValue(_ sender: Notification) {
    guard let userInfo = sender.userInfo as? [String: Int] else {
      debugPrint("failed to observe value")
      return
    }
    
    guard let productsCount = userInfo[AppDefaults.Strings.Keys.cartCount] else {
      debugPrint("nothing in userInfo found")
      return
    }
    
    let productsExists = productsCount >= 1
    
    tabBar.items?.forEach { 
      if $0.title == AppDefaults.ControllerName.cart {
        $0.badgeColor = productsExists ? AppDefaults.Colors.buttons : nil
        $0.badgeValue = productsExists ? "\(productsCount)" : nil
      }
    }
  }
}
