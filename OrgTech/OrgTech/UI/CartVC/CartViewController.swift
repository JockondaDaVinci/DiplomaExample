//
//  CartViewController.swift
//  OrgTech
//
//  Created by Maksym Balukhtin on 22.04.2020.
//  Copyright © 2020 Maksym Balukhtin. All rights reserved.
//

import Foundation
import UIKit

enum CartViewEvent {
  case onProceedButtonAction
  case onTableViewEvent(CartTableViewManagerEvent)
}


protocol CartPresenterToView: AnyObject {
  func setupInitialState()
  func updateUI(with data: [ShortProductModel])
}


final class CartViewController: BuildableViewController<CartView>, TabRepresentile {
  var presenter: CartViewToPresenter?
  var relatedTabBarItem: UITabBarItem? = AppDefaults.TabIndicator.cart
  var tableViewManager: CartTableViewManager?

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    presenter?.onViewAppeared()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    presenter?.onViewLoaded()
  }
}


extension CartViewController: CartPresenterToView {
  func setupInitialState() {
    setupUI()
  }
  
  func updateUI(with data: [ShortProductModel]) {
    navigationItem.rightBarButtonItem?.isEnabled = !data.isEmpty
    guard !data.isEmpty else {
      mainView.tableView.isHidden = true
      mainView.emptyLabel.isHidden = false
      return
    }
    
    mainView.tableView.isHidden = false
    mainView.emptyLabel.isHidden = true
    tableViewManager = CartTableViewManager(mainView.tableView, data: data)
    tableViewManager?.eventHandler = { [unowned self] event in
      self.presenter?.onViewEvent(.onTableViewEvent(event))
    }
  }
}


private extension CartViewController {
  func setupUI() {
    let proceedButton = UIButton()
    proceedButton.setImage(AppDefaults.Images.Buttons.checkButton, for: .normal)
    
    proceedButton.addAction(for: .touchUpInside) { [unowned self] in
      self.presenter?.onViewEvent(.onProceedButtonAction)
    }
    
    navigationItem.title = AppDefaults.ControllerName.cart
    
    navigationItem.rightBarButtonItem = UIBarButtonItem(customView: proceedButton)
    
    navigationItem.rightBarButtonItem?.isEnabled = false
  }
}
