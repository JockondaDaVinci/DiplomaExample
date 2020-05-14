//
//  MenuViewController.swift
//  OrgTech
//
//  Created by Maksym Balukhtin on 22.04.2020.
//  Copyright © 2020 Maksym Balukhtin. All rights reserved.
//

import Foundation
import UIKit

enum MenuViewEvent {
  case onTableViewEvent(MenuTableViewManagerEvent)
}

protocol MenuPresenterToView: AnyObject {
  func setupInitialState()
  func populateData(_ data: WrapperModel<CategoryModel>)
}


final class MenuViewController: BuildableViewController<MenuView>, TabRepresentile {
  var presenter: MenuViewToPresenter?
  var relatedTabBarItem: UITabBarItem? = AppDefaults.TabIndicator.menu
  var tableViewManager: MenuTableViewManager?

  override func viewDidLoad() {
    super.viewDidLoad()
    presenter?.onViewLoaded()
  }
}


extension MenuViewController: MenuPresenterToView {
  func populateData(_ data: [CategoryModel]) {
    tableViewManager = MenuTableViewManager(mainView.tableView, data: data)
    setupActions()
  }
  
  func setupInitialState() {
    setupUI()
  }
}


private extension MenuViewController {
  func setupActions() {
    tableViewManager?.eventHandler = { [unowned self] event in
      self.presenter?.onViewEvent(.onTableViewEvent(event))
    }
  }
  
  func setupUI() {
    title = AppDefaults.ControllerName.menu
  }
}
