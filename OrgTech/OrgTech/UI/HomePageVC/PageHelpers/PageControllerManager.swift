//
//  PageControllerManager.swift
//  OrgTech
//
//  Created by Maksym Balukhtin on 30.04.2020.
//  Copyright © 2020 Maksym Balukhtin. All rights reserved.
//

import UIKit

enum PageControllerManagerEvent {
  case onPageChanged(Int)
}

class PageControllerManager: NSObject {
  private let pageController: UIPageViewController
  private var viewControllers = [UIViewController]()
  private var lastKnownController: UIViewController?
  
  var eventHandler: EventHandler<PageControllerManagerEvent>?
  
  init(_ pageController: UIPageViewController) {
    self.pageController = pageController
    super.init()
    pageController.dataSource = self
    pageController.delegate = self
  }
  
  func populateControllers(relatedTo data: [MainModelProtocol]) {
    let topModel = data.filter { $0.top != nil }
    let saleModel = data.filter { $0.sale != nil }
    
    viewControllers = [topModel, saleModel].map { model -> UIViewController in
      var module = HomeBuilder.create()
      module.presenter.insertedData = model
      return module.view.viewController
    }
    
    pageController.setViewControllers([viewControllers[0]], direction: .forward, animated: false, completion: nil)
  }
  
  func selectPage(at index: Int) {
    let direction: UIPageViewController.NavigationDirection = index < viewControllers.count - 1 ? .reverse : .forward
    pageController.setViewControllers([viewControllers[index]], direction: direction, animated: true, completion: nil)
  }
}

extension PageControllerManager: UIPageViewControllerDataSource {
  func presentationCount(for pageViewController: UIPageViewController) -> Int {
    return 2
  }
  
  func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
    if let index = viewControllers.firstIndex(of: viewController) {
      if index == 0 {
        return viewControllers.last
      } else {
        return viewControllers[index - 1]
      }
    }
    return nil
  }
  
  func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
    if let index = viewControllers.firstIndex(of: viewController) {
      if index < viewControllers.count - 1 {
        return viewControllers[index + 1]
      } else {
        return viewControllers.first
      }
    }
    return nil
  }
}

extension PageControllerManager: UIPageViewControllerDelegate {
  func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
    if let controllers = pageViewController.viewControllers, let index = self.viewControllers.firstIndex(of: controllers[0]) {
      eventHandler?(.onPageChanged(index))
    }
  }
}
