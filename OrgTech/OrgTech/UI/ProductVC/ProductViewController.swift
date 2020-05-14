//
//  ProductViewController.swift
//  OrgTech
//
//  Created by Maksym Balukhtin on 22.04.2020.
//  Copyright © 2020 Maksym Balukhtin. All rights reserved.
//

import Foundation
import UIKit

enum ProductViewEvent {
  case onTableViewEvent(ProductTableViewManagerEvent)
}


protocol ProductPresenterToView: AnyObject {
  func setupInitialState()
  func loadProductDetails(_ data: ProductModel)
  func changeButtonsTitles(_ inCart: Bool, followed: Bool)
}


final class ProductViewController: BuildableViewController<ProductView> {
  var presenter: ProductViewToPresenter?
  var tableViewManager: ProductTableViewManager?

  override func viewDidLoad() {
    super.viewDidLoad()
    presenter?.onViewLoaded()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    presenter?.onViewAppeared()
  }
}


extension ProductViewController: ProductPresenterToView {
  func setupInitialState() {
    
  }
  
  func loadProductDetails(_ data: ProductModel) {
    tableViewManager = ProductTableViewManager(mainView.tableView, data: data)
    title = data.name
    setupActions()
  }
  
  func changeButtonsTitles(_ inCart: Bool, followed: Bool) {
    tableViewManager?.reloadButtons(inCart, followed)
  }
}


private extension ProductViewController {
  func setupActions() {
    tableViewManager?.eventHandler = { [unowned self] event in
      self.presenter?.onViewEvent(.onTableViewEvent(event))
    }
  }
}
