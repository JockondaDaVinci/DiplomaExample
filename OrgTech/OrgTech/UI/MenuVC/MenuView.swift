//
//  MenuView.swift
//  OrgTech
//
//  Created by Maksym Balukhtin on 22.04.2020.
//  Copyright © 2020 Maksym Balukhtin. All rights reserved.
//

import UIKit

class MenuView: BuildableView {
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
    
    tableView.register(cell: MenuTableViewCell.self)
  }
}

