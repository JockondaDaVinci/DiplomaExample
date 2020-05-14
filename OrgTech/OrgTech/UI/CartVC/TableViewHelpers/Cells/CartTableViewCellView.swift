//
//  CartTableViewCellView.swift
//  OrgTech
//
//  Created by Maksym Balukhtin on 29.04.2020.
//  Copyright © 2020 Maksym Balukhtin. All rights reserved.
//

import UIKit

final class CartTableViewCellView: BuildableView {
  //MARK: Subviews
  let imageView = UIImageView()
  let nameLabel = UILabel()
  let colorPicker = ColorPickerView()
  private let priceStackView = UIStackView()
  let qtyPriceLabel = UILabel()
  let finalPriceLabel = UILabel()
  
  override func addViews() {
    //add subviews into array
    [qtyPriceLabel, finalPriceLabel].forEach {
      priceStackView.addArrangedSubview($0)
    }
    
    [imageView, nameLabel, colorPicker, priceStackView].forEach{addSubview($0)}
  }
  
  override func anchorViews() {
    imageView
      .anchorTop(topAnchor, 5.0)
      .anchorBottom(bottomAnchor, 5.0)
      .anchorLeft(leftAnchor, 10.0)
      .anchorEqualWidth(imageView.heightAnchor)
    
    priceStackView
      .anchorTop(imageView.topAnchor, 0.0)
      .anchorBottom(imageView.bottomAnchor, 0.0)
      .anchorRight(rightAnchor, 10.0)
      .anchorWidth(100.0)
    
    colorPicker
      .anchorTop(imageView.topAnchor, 5.0)
      .anchorBottom(imageView.bottomAnchor, 10.0)
      .anchorEqualWidth(colorPicker.heightAnchor)
      .anchorRight(priceStackView.leftAnchor, 5.0)
    
    nameLabel
      .anchorLeft(imageView.rightAnchor, 10.0)
      .anchorRight(colorPicker.leftAnchor, 10.0)
      .anchorCenterYToSuperview()
  }
  
  override func configureViews() {
    backgroundColor = .white
    
    imageView.contentMode = .scaleAspectFit
    
    priceStackView.axis = .vertical
    priceStackView.alignment = .center
    priceStackView.distribution = .fillEqually
    
    nameLabel.font = .systemFont(ofSize: 15.0)
    nameLabel.numberOfLines = 0
    
    qtyPriceLabel.font = .systemFont(ofSize: 13.0)
    qtyPriceLabel.textAlignment = .center
    qtyPriceLabel.textColor = .lightGray
    
    finalPriceLabel.textAlignment = .center
  }
}
