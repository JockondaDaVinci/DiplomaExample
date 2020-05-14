//
//  DescriptionCellView.swift
//  OrgTech
//
//  Created by Maksym Balukhtin on 28.04.2020.
//  Copyright © 2020 Maksym Balukhtin. All rights reserved.
//

import UIKit

final class DescriptionCellView: BuildableView {
  //MARK: Subviews
  let descLabel = UILabel()
  
  override func addViews() {
    //add subviews into array
    [descLabel].forEach{addSubview($0)}
  }
  
  override func anchorViews() {
    descLabel
      .anchorTop(topAnchor, 10.0)
      .anchorLeft(leftAnchor, 10.0)
      .anchorRight(rightAnchor, 10.0)
      .anchorBottom(bottomAnchor, 10.0)
  }
  
  override func configureViews() {
    descLabel.numberOfLines = 0
    descLabel.font = .systemFont(ofSize: 14.0)
  }
}
