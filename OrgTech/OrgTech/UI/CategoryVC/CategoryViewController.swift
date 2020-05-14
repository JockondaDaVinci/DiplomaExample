//
//  CategoryViewController.swift
//  OrgTech
//
//  Created by Maksym Balukhtin on 29.04.2020.
//  Copyright © 2020 Maksym Balukhtin. All rights reserved.
//

import Foundation
import UIKit

enum CategoryViewEvent {
  case onCollectionViewAction(CollectionViewManagerEvent)
  case onFilterButtonAction
}


protocol CategoryPresenterToView: AnyObject {
  func setupInitialState()
  func populateData(_ data: [MainModelProtocol])
  func setupEmptyData(_ message: String)
}


final class CategoryViewController: BuildableViewController<CategoryView> {
  var presenter: CategoryViewToPresenter?
  var collectionManager: CollectionViewManager?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    presenter?.onViewLoaded()
  }
}


extension CategoryViewController: CategoryPresenterToView {
  func setupInitialState() { }
  
  func populateData(_ data: [MainModelProtocol]) {
    navigationItem.title = (data.first as? CategoryContentModel)?.categoryName
    guard !data.isEmpty else {
      setupEmptyData()
      return()
    }
    collectionManager = CollectionViewManager(mainView.collectionView, data: data)
    
    mainView.collectionView.isHidden = false
    mainView.emptyLabel.isHidden = true
    
    setupUI()
    setupActions()
  }
  
  func setupEmptyData(_ message: String = "") {
    collectionManager = nil
    mainView.collectionView.isHidden = true
    mainView.emptyLabel.isHidden = false
    mainView.emptyLabel.text = !message.isEmpty ? message : mainView.emptyLabel.text
  }
}


private extension CategoryViewController {
  func setupActions() {
    collectionManager?.eventHandler = { [unowned self] event in
      self.presenter?.onViewEvent(.onCollectionViewAction(event))
    }
  }
  
  func setupUI() {
    let filterButton = UIButton()
    filterButton.setBackgroundImage(AppDefaults.Images.Buttons.filterButton, for: .normal)
    
    filterButton.addAction(for: .touchUpInside) { [unowned self] in
      self.presenter?.onViewEvent(.onFilterButtonAction)
    }
    
    navigationItem.rightBarButtonItem = UIBarButtonItem(customView: filterButton)
  }
}
