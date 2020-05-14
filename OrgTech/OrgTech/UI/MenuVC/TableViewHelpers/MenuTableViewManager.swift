//
//  MenuTableViewManager.swift
//  OrgTech
//
//  Created by Maksym Balukhtin on 22.04.2020.
//  Copyright © 2020 Maksym Balukhtin. All rights reserved.
//

import UIKit

enum MenuTableViewManagerEvent {
  case onCategoryAction(String)
}

final class MenuTableViewManager: NSObject {
  private var items: [CategoryModel]
  
  var eventHandler: EventHandler<MenuTableViewManagerEvent>?
  
  init(_ tableView: UITableView, data: [CategoryModel]) {
    items = [CategoryModel(categoryID: "-1", name: "Favourites", isStatic: true)]
    items.append(contentsOf:  data)
    super.init()
    tableView.dataSource = self
    tableView.delegate = self
    tableView.reloadData()
  }
}

extension MenuTableViewManager: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return items.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let item = items[indexPath.row]
    guard let cell = tableView.dequeue(cellOfType: MenuTableViewCell.self, for: indexPath) else { return UITableViewCell() }
    cell.config(with: item)
    return cell
  }
}

extension MenuTableViewManager: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 44.0
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let item = items[indexPath.row]
    eventHandler?(.onCategoryAction(item.categoryID))
  }
}
