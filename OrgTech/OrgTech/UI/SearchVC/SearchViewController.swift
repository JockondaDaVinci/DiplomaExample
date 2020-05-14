//
//  SearchViewController.swift
//  OrgTech
//
//  Created by Maksym Balukhtin on 22.04.2020.
//  Copyright © 2020 Maksym Balukhtin. All rights reserved.
//

import Foundation
import UIKit

enum SearchViewEvent {
  case onTableViewEvent(SearchTableViewManagerEvent)
  case onSeacrhEvent(SearchManagerEvent)
}


protocol SearchPresenterToView: AnyObject {
  func setupInitialState()
  func populateSearchData(_ data: [ShortProductModel])
  func clear(_ totally: Bool)
  func showError()
}


final class SearchViewController: BuildableViewController<SearchView>, TabRepresentile {
  var presenter: SearchViewToPresenter?
  var relatedTabBarItem: UITabBarItem? = AppDefaults.TabIndicator.search
  var tableViewManager: SearchTableViewManager?
  var searchManager: SearchManager?

  override func viewDidLoad() {
    super.viewDidLoad()
    presenter?.onViewLoaded()
  }
}


extension SearchViewController: SearchPresenterToView {
  func setupInitialState() {
    setupUI()
    setupActions()
  }
  
  func populateSearchData(_ data: [ShortProductModel]) {
    guard !data.isEmpty else {
      mainView.tableView.isHidden = true
      mainView.tipLabel.isHidden = false
      return
    }
    
    mainView.tableView.isHidden = false
    mainView.tipLabel.isHidden = true
    
    tableViewManager = SearchTableViewManager(mainView.tableView, data: data)
    tableViewManager?.eventHandler = { [unowned self] event in
      self.presenter?.onViewEvent(.onTableViewEvent(event))
    }
  }
  
  func clear(_ totally: Bool = false) {
    tableViewManager = nil
    mainView.tableView.isHidden = true
    mainView.tipLabel.isHidden = false
    
    mainView.tipLabel.text = totally ? AppDefaults.Strings.Label.searchTip : mainView.tipLabel.text
  }
  
  func showError() {
    clear()
    
    mainView.tipLabel.text = AppDefaults.Strings.Label.searchEmpty
  }
}


private extension SearchViewController {
  func setupUI() {
    let searchBar = UISearchBar()
    searchBar.placeholder = AppDefaults.Strings.Placeholder.search
    searchManager = SearchManager(searchBar)
    
    navigationItem.titleView = searchBar
    isKeyboardHandlable = true
  }
  
  func setupActions() {
    searchManager?.eventHandler = { [unowned self] event in
      self.presenter?.onViewEvent(.onSeacrhEvent(event))
    }
  }
}
