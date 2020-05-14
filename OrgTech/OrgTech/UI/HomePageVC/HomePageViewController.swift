//
//  HomePageViewController.swift
//  OrgTech
//
//  Created by Maksym Balukhtin on 22.04.2020.
//  Copyright © 2020 Maksym Balukhtin. All rights reserved.
//

import Foundation
import UIKit

enum HomePageViewEvent {
  case onPageControlEvent(PageControllerManagerEvent)
  case onSegmentEvent(Int)
}


protocol HomePagePresenterToView: AnyObject {
  func setupInitialState()
  func populateData(_ items: [MainModelProtocol])
  func adjustControls(with index: Int, segment: Bool)
}


final class HomePageViewController: BuildableViewController<HomePageView>, TabRepresentile {
  var presenter: HomePageViewToPresenter?
  var relatedTabBarItem: UITabBarItem? = AppDefaults.TabIndicator.home
  lazy var pageController: UIPageViewController = {
    return UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
  }()
  var pageControllerManager: PageControllerManager?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    presenter?.onViewLoaded()
  }
}


extension HomePageViewController: HomePagePresenterToView {
  func populateData(_ items: [MainModelProtocol]) {
    pageControllerManager?.populateControllers(relatedTo: items)
    
    setupActions()
  }
  
  func adjustControls(with index: Int, segment: Bool) {
    if segment {
      mainView.segmentControl.selectedSegmentIndex = index
    } else {
      pageControllerManager?.selectPage(at: index)
    }
  }
  
  func setupInitialState() {
    pageControllerManager = PageControllerManager(pageController)
    pageController.view.frame = mainView.contentView.frame
    addChild(pageController)
    mainView.contentView.addSubview(pageController.view)
    pageController.didMove(toParent: self)
    
    let headerView = UIImageView(image: AppDefaults.Images.logo)
    navigationItem.titleView = headerView
  }
}


private extension HomePageViewController {
  func setupActions() {
    pageControllerManager?.eventHandler = { [unowned self] event in
      self.presenter?.onViewEvent(.onPageControlEvent(event))
    }
    
    mainView.segmentControl.addAction(for: .valueChanged) { [unowned self] in
      self.presenter?.onViewEvent(.onSegmentEvent(self.mainView.segmentControl.selectedSegmentIndex))
    }
  }
}
