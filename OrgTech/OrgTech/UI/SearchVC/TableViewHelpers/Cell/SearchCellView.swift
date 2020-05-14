//
//  SearchCellView.swift
//  OrgTech
//
//  Created by Maksym Balukhtin on 29.04.2020.
//  Copyright © 2020 Maksym Balukhtin. All rights reserved.
//

import UIKit

final class SearchCellView: BuildableView {
  //MARK: Subviews
  let imageView = UIImageView()
  let nameLabel = UILabel()
  let priceLabel = UILabel()
  
  override func addViews() {
    //add subviews into array
    [imageView, nameLabel, priceLabel].forEach{addSubview($0)}
  }
  
  override func anchorViews() {
    imageView
      .anchorTop(topAnchor, 5.0)
      .anchorLeft(leftAnchor, 10.0)
      .anchorBottom(bottomAnchor, 5.0)
      .anchorHeight(50.0)
      .anchorEqualWidth(imageView.heightAnchor)
    
    priceLabel
      .anchorRight(rightAnchor, 10.0)
      .anchorCenterYToSuperview()
    
    nameLabel
      .anchorLeft(imageView.rightAnchor, 10.0)
      .anchorRight(priceLabel.leftAnchor, 10.0)
      .anchorCenterYToSuperview()
  }
  
  override func configureViews() {
    backgroundColor = .white
    
    imageView.contentMode = .scaleAspectFit
    
    priceLabel.textAlignment = .right
    nameLabel.textAlignment = .left
  }
}
