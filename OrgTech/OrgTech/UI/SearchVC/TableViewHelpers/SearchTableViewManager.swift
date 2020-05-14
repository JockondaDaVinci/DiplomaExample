//
//  SearchTableViewManager.swift
//  OrgTech
//
//  Created by Maksym Balukhtin on 29.04.2020.
//  Copyright © 2020 Maksym Balukhtin. All rights reserved.
//

import UIKit

enum SearchTableViewManagerEvent {
  case onItemsSelected(String)
}

class SearchTableViewManager: NSObject {
  private var data = [ShortProductModel]()
  
  var eventHandler: EventHandler<SearchTableViewManagerEvent>?
  
  init(_ tableView: UITableView, data: [ShortProductModel]) {
    self.data = data
    super.init()
    
    tableView.delegate = self
    tableView.dataSource = self
    tableView.reloadData()
  }
}

extension SearchTableViewManager: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return data.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let item = data[indexPath.row]
    guard let cell = tableView.dequeue(cellOfType: SearchCell.self, for: indexPath) else { return UITableViewCell() }
    cell.config(with: item)
    return cell
  }
}

extension SearchTableViewManager: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let item = data[indexPath.row]
    eventHandler?(.onItemsSelected(item.id))
  }
}
