//
//  CollectionViewManager.swift
//  OrgTech
//
//  Created by Maksym Balukhtin on 22.04.2020.
//  Copyright © 2020 Maksym Balukhtin. All rights reserved.
//

import UIKit

enum CollectionViewManagerEvent {
  case onCellAction(String)
}

class CollectionViewManager: NSObject {
  private var items = [MainModelProtocol]()
  
  var eventHandler: EventHandler<CollectionViewManagerEvent>?
  
  init(_ collectionView: UICollectionView, data: [MainModelProtocol]) {
    super.init()
    items = data
    collectionView.dataSource = self
    collectionView.delegate = self
    collectionView.reloadData()
  }
}

extension CollectionViewManager: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return items.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let item = items[indexPath.item]
    guard let cell = collectionView.dequeue(cellOfType: CollectionViewCell.self, for: indexPath) else { return UICollectionViewCell() }
    cell.config(with: item)
    return cell
  }
}

extension CollectionViewManager: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    guard let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout else { return .zero }
    let width = collectionView.bounds.width / 2 - flowLayout.minimumInteritemSpacing
    let height = width + 70.0
    return CGSize(width: width, height: height)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 5.0
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: 5.0, left: 5.0, bottom: 5.0, right: 5.0)
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 5.0
  }
}

extension CollectionViewManager: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let item = items[indexPath.item]
    eventHandler?(.onCellAction(item.productID))
  }
}
