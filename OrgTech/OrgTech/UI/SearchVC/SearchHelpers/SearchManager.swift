//
//  SearchManager.swift
//  OrgTech
//
//  Created by Maksym Balukhtin on 29.04.2020.
//  Copyright © 2020 Maksym Balukhtin. All rights reserved.
//

import UIKit

enum SearchManagerEvent {
  case onSearchButtonAction(String?)
  case onCancelButtonAction
}

class SearchManager: NSObject {
  var eventHandler: EventHandler<SearchManagerEvent>?
  
  init(_ searchBar: UISearchBar) {
    super.init()
    searchBar.delegate = self
  }
}

extension SearchManager: UISearchBarDelegate {
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    eventHandler?(.onSearchButtonAction(searchBar.text))
  }
  
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    if searchText.isEmpty {
      eventHandler?(.onCancelButtonAction)
    }
  }
}
