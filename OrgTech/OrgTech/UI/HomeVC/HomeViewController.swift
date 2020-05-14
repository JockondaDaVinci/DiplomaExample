//
//  HomeViewController.swift
//  OrgTech
//
//  Created by Maksym Balukhtin on 22.04.2020.
//  Copyright © 2020 Maksym Balukhtin. All rights reserved.
//

import UIKit

enum HomeViewEvents {
  case onCollectionViewEvent(CollectionViewManagerEvent)
}

protocol HomePresenterToView: AnyObject {
  func setupInitialState()
  func populateData(_ items: [MainModelProtocol])
}

final class HomeViewController: BuildableViewController<HomeView> {
  var presenter: HomeViewToPrester?
  var collectionManager: CollectionViewManager?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    presenter?.onViewLoaded()
  }
}

extension HomeViewController: HomePresenterToView {
  func populateData(_ items: [MainModelProtocol]) {
    collectionManager = CollectionViewManager(mainView.collectionView, data: items)
    setupActions()
  }
  
  func setupInitialState() {
    
  }
}

private extension HomeViewController {
  func setupActions() {
    collectionManager?.eventHandler = { [unowned self] event in
      self.presenter?.onViewEvent(.onCollectionViewEvent(event))
    }
  }
}
