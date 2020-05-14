//
//  UICollectionView+Extensions.swift
//  OrgTech
//
//  Created by Maksym Balukhtin on 22.04.2020.
//  Copyright © 2020 Maksym Balukhtin. All rights reserved.
//

import UIKit

extension UICollectionView {
  func dequeue<CellType: UICollectionViewCell>(cellOfType type: CellType.Type, for indexPath: IndexPath) -> CellType? {
    return dequeueReusableCell(withReuseIdentifier: type.reuseId, for: indexPath) as? CellType
  }
  
  func register<CellType: UICollectionViewCell>(cell: CellType.Type) {
    register(cell, forCellWithReuseIdentifier: cell.reuseId)
  }
}
