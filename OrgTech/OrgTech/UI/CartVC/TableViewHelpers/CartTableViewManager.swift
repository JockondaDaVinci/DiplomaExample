//
//  CartTableViewManager.swift
//  OrgTech
//
//  Created by Maksym Balukhtin on 29.04.2020.
//  Copyright © 2020 Maksym Balukhtin. All rights reserved.
//

import UIKit

enum CartTableViewManagerEvent {
  case onItemDelete(ShortProductModel)
}

class CartTableViewManager: NSObject {
  private var data = [ShortProductModel]()
  
  var eventHandler: EventHandler<CartTableViewManagerEvent>?
  
  init(_ tableView: UITableView, data: [ShortProductModel]) {
    self.data = data
    super.init()
    
    tableView.delegate = self
    tableView.dataSource = self
    tableView.reloadData()
  }
}

extension CartTableViewManager: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return data.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let item = data[indexPath.row]
    
    guard let cell = tableView.dequeue(cellOfType: CartTableViewCell.self, for: indexPath) else { return UITableViewCell() }
    cell.config(with: item)
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 60.0
  }
}

extension CartTableViewManager: UITableViewDelegate {
  func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    return true
  }
  
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    guard editingStyle == .delete else { return }
    
    tableView.beginUpdates()
    tableView.deleteRows(at: [indexPath], with: .automatic)
    let item = data[indexPath.row]
    eventHandler?(.onItemDelete(item))
    data.remove(at: indexPath.row)
    tableView.endUpdates()
  }
}
