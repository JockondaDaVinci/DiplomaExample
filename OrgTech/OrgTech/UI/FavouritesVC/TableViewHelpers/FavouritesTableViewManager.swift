//
//  FavouritesTableViewManager.swift
//  OrgTech
//
//  Created by Maksym Balukhtin on 01.05.2020.
//  Copyright © 2020 Maksym Balukhtin. All rights reserved.
//

import UIKit

enum FavouritesTableViewManagerEvent {
  case onItemDelete(ShortProductModel)
  case onItemToCart(ShortProductModel)
}

class FavouritesTableViewManager: NSObject {
  private var data = [ShortProductModel]()
  
  var eventHandler: EventHandler<FavouritesTableViewManagerEvent>?
  
  init(_ tableView: UITableView, data: [ShortProductModel]) {
    self.data = data
    super.init()
    
    tableView.delegate = self
    tableView.dataSource = self
    tableView.reloadData()
  }
}

extension FavouritesTableViewManager: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return data.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let item = data[indexPath.row]
    
    guard let cell = tableView.dequeue(cellOfType: FovouriteTableViewCell.self, for: indexPath) else { return UITableViewCell() }
    cell.config(with: item)
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 60.0
  }
}

extension FavouritesTableViewManager: UITableViewDelegate {
  func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    return true
  }
  
  func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    let action = UIContextualAction(style: .normal, title: AppDefaults.Strings.Button.toCartButton) { [unowned self] (action, view, handler) in
      self.removeRow(at: indexPath, from: tableView, target: .toCart)
      handler(true)
    }
    action.backgroundColor = AppDefaults.Colors.buttons
    return UISwipeActionsConfiguration(actions: [action])
  }
  
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    guard editingStyle == .delete else { return }
    removeRow(at: indexPath, from: tableView, target: .delete)
  }
}

private extension FavouritesTableViewManager {
  enum EditingTarget {
    case delete
    case toCart
  }
  
  func removeRow(at indexPath: IndexPath, from tableView: UITableView, target: EditingTarget) {
    tableView.beginUpdates()
    tableView.deleteRows(at: [indexPath], with: .automatic)
    let item = data[indexPath.row]
    if target == .delete {
      eventHandler?(.onItemDelete(item))
    } else {
      eventHandler?(.onItemToCart(item))
    }
    data.remove(at: indexPath.row)
    tableView.endUpdates()
  }
}
