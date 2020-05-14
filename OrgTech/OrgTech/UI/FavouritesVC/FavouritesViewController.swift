//
//  FavouritesViewController.swift
//  OrgTech
//
//  Created by Maksym Balukhtin on 01.05.2020.
//  Copyright © 2020 Maksym Balukhtin. All rights reserved.
//

import Foundation
import UIKit

enum FavouritesViewEvent {
  case onTableViewEvent(FavouritesTableViewManagerEvent)
}


protocol FavouritesPresenterToView: AnyObject {
  func setupInitialState()
  func populateData(_ data: [ShortProductModel])
}


final class FavouritesViewController: BuildableViewController<FavouritesView> {
  var presenter: FavouritesViewToPresenter?
  var tableViewManager: FavouritesTableViewManager?

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    presenter?.onViewFirstWillAppear()
  }
}


extension FavouritesViewController: FavouritesPresenterToView {
  func setupInitialState() {
    navigationItem.title = "Favourites"
  }
  
  func populateData(_ data: [ShortProductModel]) {
    guard !data.isEmpty else {
      mainView.tableView.isHidden = true
      mainView.emptyLabel.isHidden = false
      return
    }
    
    mainView.tableView.isHidden = false
    mainView.emptyLabel.isHidden = true
    tableViewManager = FavouritesTableViewManager(mainView.tableView, data: data)
    setupActions()
  }
}


private extension FavouritesViewController {
  func setupActions() {
    tableViewManager?.eventHandler = { [unowned self] event in
      self.presenter?.onViewEvent(.onTableViewEvent(event))
    }
  }
}
