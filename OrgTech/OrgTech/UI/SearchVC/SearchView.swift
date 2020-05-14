//
//  SearchView.swift
//  OrgTech
//
//  Created by Maksym Balukhtin on 22.04.2020.
//  Copyright © 2020 Maksym Balukhtin. All rights reserved.
//

import UIKit

class SearchView: BuildableView {
  //MARK: Subviews
  let tableView = UITableView()
  let tipLabel = UILabel()
  
  override func addViews() {
    //add subviews into array
    [tableView, tipLabel].forEach{addSubview($0)}
  }
  
  override func anchorViews() {
    tableView.fillSuperview()
    
    tipLabel.fillSuperview()
  }
  
  override func configureViews() {
    tableView.backgroundColor = .white
    
    tableView.showsVerticalScrollIndicator = false
    tableView.showsHorizontalScrollIndicator = false
    tableView.bounces = true
    tableView.isHidden = true
    tableView.keyboardDismissMode = .onDrag
    
    tableView.register(cell: SearchCell.self)
    
    tipLabel.backgroundColor = .white
    tipLabel.font = .systemFont(ofSize: 17.0)
    tipLabel.numberOfLines = 0
    tipLabel.textAlignment = .center
    tipLabel.textColor = .lightGray
    tipLabel.text = AppDefaults.Strings.Label.searchTip
  }
}

