//
//  FovouriteTableViewCellView.swift
//  OrgTech
//
//  Created by Maksym Balukhtin on 01.05.2020.
//  Copyright © 2020 Maksym Balukhtin. All rights reserved.
//

import UIKit

final class FovouriteTableViewCellView: BuildableView {
  //MARK: Subviews
  let imageView = UIImageView()
  let nameLabel = UILabel()
  
  override func addViews() {
    //add subviews into array
    [imageView, nameLabel].forEach{addSubview($0)}
  }
  
  override func anchorViews() {
    imageView
    .anchorTop(topAnchor, 5.0)
    .anchorBottom(bottomAnchor, 5.0)
    .anchorLeft(leftAnchor, 10.0)
    .anchorEqualWidth(imageView.heightAnchor)
    
    nameLabel
    .anchorLeft(imageView.rightAnchor, 10.0)
    .anchorRight(rightAnchor, 10.0)
    .anchorCenterYToSuperview()
  }
  
  override func configureViews() {
    backgroundColor = .white
    imageView.contentMode = .scaleAspectFit
    
    nameLabel.font = .systemFont(ofSize: 15.0)
    nameLabel.numberOfLines = 0
  }
}
