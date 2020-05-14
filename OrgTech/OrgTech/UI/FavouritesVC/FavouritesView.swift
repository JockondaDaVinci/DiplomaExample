//
//  FavouritesView.swift
//  OrgTech
//
//  Created by Maksym Balukhtin on 01.05.2020.
//  Copyright © 2020 Maksym Balukhtin. All rights reserved.
//

import UIKit

class FavouritesView: BuildableView {
  //MARK: Subviews
  let tableView = UITableView()
  let emptyLabel = UILabel()
  
  override func addViews() {
    //add subviews into array
    [emptyLabel, tableView].forEach{addSubview($0)}
  }
  
  override func anchorViews() {
    tableView.fillSuperview()
    
    emptyLabel.fillSuperview()
  }
  
  override func configureViews() {
    [tableView, emptyLabel].forEach {
      $0.backgroundColor = .white
    }
    
    tableView.showsVerticalScrollIndicator = false
    tableView.showsHorizontalScrollIndicator = false
    tableView.bounces = true
    tableView.isHidden = true
    
    tableView.register(cell: FovouriteTableViewCell.self)
    
    emptyLabel.font = .systemFont(ofSize: 17.0)
    emptyLabel.numberOfLines = 0
    emptyLabel.textAlignment = .center
    emptyLabel.textColor = .lightGray
    emptyLabel.text = AppDefaults.Strings.Label.cartFollowEmpty
  }
}

