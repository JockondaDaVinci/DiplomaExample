//
//  TableViewCellView.swift
//  OrgTech
//
//  Created by Maksym Balukhtin on 22.04.2020.
//  Copyright © 2020 Maksym Balukhtin. All rights reserved.
//

import UIKit

final class TableViewCellView: BuildableView {
  //MARK: Subviews
  let titleLabel = UILabel()
  let countView = SpecialOfferView()
  
  override func addViews() {
    //add subviews into array
    [titleLabel, countView].forEach{addSubview($0)}
  }
  
  override func anchorViews() {
    titleLabel
      .anchorLeft(leftAnchor, 10.0)
      .anchorCenterYToView(self)
    
    countView
      .anchorRight(rightAnchor, 10.0)
      .anchorLeft(titleLabel.rightAnchor, 10.0)
      .anchorHeight(30.0)
      .anchorWidth(30.0)
      .anchorCenterYToView(self)
  }
  
  override func configureViews() {
    backgroundColor = .white
    
    
    titleLabel.textColor = AppDefaults.Colors.Text.default
    titleLabel.textAlignment = .left
    titleLabel.numberOfLines = 0
  }
}
