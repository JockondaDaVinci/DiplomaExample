//
//  ProductView.swift
//  OrgTech
//
//  Created by Maksym Balukhtin on 22.04.2020.
//  Copyright © 2020 Maksym Balukhtin. All rights reserved.
//

import UIKit

class ProductView: BuildableView {
  //MARK: Subviews
  let tableView = UITableView()
  
  override func addViews() {
    //add subviews into array
    [tableView].forEach{addSubview($0)}
  }
  
  override func anchorViews() {
    tableView.fillSuperview()
  }
  
  override func configureViews() {
    tableView.backgroundColor = .white
    
    tableView.showsVerticalScrollIndicator = false
    tableView.showsHorizontalScrollIndicator = false
    tableView.bounces = true
    tableView.allowsSelection = false
    tableView.separatorStyle = .none
    
    tableView.register(cell: ProductImageCell.self)
    tableView.register(cell: ProductMainInfoCell.self)
    tableView.register(cell: DescriptionCell.self)
    tableView.register(cell: ReviewCell.self)
    
    tableView.register(cell: SectionHeaderCell.self)
  }
}

