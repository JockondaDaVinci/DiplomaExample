//
//  ProductImageCellView.swift
//  OrgTech
//
//  Created by Maksym Balukhtin on 23.04.2020.
//  Copyright © 2020 Maksym Balukhtin. All rights reserved.
//

import UIKit

final class ProductImageCellView: BuildableView {
  //MARK: Subviews
  let imageView = UIImageView()
  
  override func addViews() {
    //add subviews into array
    [imageView].forEach{addSubview($0)}
  }
  
  override func anchorViews() {
    imageView
      .anchorTop(topAnchor, 10.0)
      .anchorLeft(leftAnchor, 10.0)
      .anchorRight(rightAnchor, 10.0)
      .anchorBottom(bottomAnchor, 10.0)
      .anchorHeight(200.0)
  }
  
  override func configureViews() {
    backgroundColor = .white
    imageView.contentMode = .scaleAspectFit
  }
}
