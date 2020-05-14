//
//  UITableView+Extensions.swift
//  OrgTech
//
//  Created by Maksym Balukhtin on 22.04.2020.
//  Copyright © 2020 Maksym Balukhtin. All rights reserved.
//

import UIKit

extension UITableView {
  func dequeue<CellType: UITableViewCell>(cellOfType type: CellType.Type, for indexPath: IndexPath) -> CellType? {
    return dequeueReusableCell(withIdentifier: type.reuseId, for: indexPath) as? CellType
  }
  
  func dequeueSupplementaryView<SupplementaryType: UIView>(viewOfType type: SupplementaryType.Type) -> SupplementaryType? {
    return dequeueReusableHeaderFooterView(withIdentifier: type.reuseId) as? SupplementaryType
  }
  
  func register<CellType: UITableViewCell>(cell: CellType.Type) {
    register(cell, forCellReuseIdentifier: cell.reuseId)
  }
  
  func registerSupplementaryView<SupplementaryType: UIView>(view: SupplementaryType.Type) {
    register(view, forHeaderFooterViewReuseIdentifier: view.reuseId)
  }
}
