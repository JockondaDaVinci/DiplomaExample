//
//  ProductTableViewManager.swift
//  OrgTech
//
//  Created by Maksym Balukhtin on 22.04.2020.
//  Copyright © 2020 Maksym Balukhtin. All rights reserved.
//

import UIKit

enum ProductTableViewManagerEvent {
  case onButtonsAction(ProductMainInfoCellEvent)
  case onAddReviewButtonAction
}

class ProductTableViewManager: NSObject {
  enum Sections: CaseIterable {
    case image
    case mainInfo
    case description
    case reviews
  }
  
  var eventHandler: EventHandler<ProductTableViewManagerEvent>?
  
  private var tableView: UITableView
  private var data: ProductModel
  
  init(_ tableView: UITableView, data: ProductModel) {
    self.tableView = tableView
    self.data = data
    super.init()
    tableView.dataSource = self
    tableView.delegate = self
    tableView.reloadData()
  }
  
  func reloadButtons(_ inCart: Bool, _ followed: Bool) {
    guard let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 1)) as? ProductMainInfoCell else { return }
    cell.setupButtonsTitles(isInCart: inCart, isFollowed: followed)
  }
}

extension ProductTableViewManager: UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return Sections.allCases.count
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    let section = Sections.allCases[section]
    switch section {
    case .reviews:
      return data.reviews.count
    default:
      return 1
    }
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let section = Sections.allCases[indexPath.section]
    let finalCell: UITableViewCell?
    
    switch section {
    case .image:
      let cell = tableView.dequeue(cellOfType: ProductImageCell.self, for: indexPath)
      cell?.config(with: data.image)
      finalCell = cell
    case .mainInfo:
      let cell = tableView.dequeue(cellOfType: ProductMainInfoCell.self, for: indexPath)
      cell?.config(with: data)
      cell?.eventHandler = { [unowned self] event in
        self.eventHandler?(.onButtonsAction(event))
      }
      finalCell = cell
    case .description:
      let cell = tableView.dequeue(cellOfType: DescriptionCell.self, for: indexPath)
      cell?.config(with: data.description)
      finalCell = cell
    case .reviews:
      let review = data.reviews[indexPath.row]
      let cell = tableView.dequeue(cellOfType: ReviewCell.self, for: indexPath)
      cell?.config(with: review)
      finalCell = cell
    }
    return finalCell ?? UITableViewCell()
  }
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let headerCell = tableView.dequeue(cellOfType: SectionHeaderCell.self, for: IndexPath(row: 0, section: section))
    let section = Sections.allCases[section]
    switch section {
    case .description:
      headerCell?.config(with: ("Description", false))
    case .reviews:
      headerCell?.config(with: ("Reviews", true))
    default:
      return nil
    }
    
    headerCell?.eventHandler = { [unowned self] action in
      self.eventHandler?(.onAddReviewButtonAction)
    }
    
    return headerCell
  }
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    let section = Sections.allCases[section]
    return section == .description || section == .reviews ? 40.0 : 0.0
  }
}

extension ProductTableViewManager: UITableViewDelegate {
  
}
