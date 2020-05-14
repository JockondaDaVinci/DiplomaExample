//
//  ProductMainInfoCellView.swift
//  OrgTech
//
//  Created by Maksym Balukhtin on 23.04.2020.
//  Copyright © 2020 Maksym Balukhtin. All rights reserved.
//

import UIKit

final class ProductMainInfoCellView: BuildableView {
  //MARK: Subviews
  let titleLabel = UILabel()
  let ratingView = RatingView()
  private let qtyStackView = UIStackView()
  let qtyView = StepperView()
  let priceLabel = UILabel()
  let colorPickerView = ColorPickerView()
  private let buttonsStackView = UIStackView()
  let buyButton = UIButton()
  let favouritesButton = UIButton()
  
  override func addViews() {
    //add subviews into array
    [qtyView, UIView(), priceLabel].forEach {
      qtyStackView.addArrangedSubview($0)
    }
    
    [buyButton, favouritesButton].forEach {
      buttonsStackView.addArrangedSubview($0)
    }
    
    [titleLabel, ratingView, qtyStackView, colorPickerView, buttonsStackView].forEach{
      addSubview($0)
    }
  }
  
  override func anchorViews() {
    titleLabel
      .anchorTop(topAnchor, 0.0)
      .anchorCenterXToView(self)
    
    ratingView
      .anchorTop(titleLabel.bottomAnchor, 10.0)
      .anchorCenterXToView(self)
      .anchorHeight(20.0)
    
    qtyStackView
      .anchorTop(ratingView.bottomAnchor, 10.0)
      .anchorLeft(leftAnchor, 20.0)
      .anchorRight(rightAnchor, 20.0)
      .anchorHeight(30.0)
    
    qtyView.anchorWidth(100.0)
    
    colorPickerView
      .anchorTop(qtyStackView.bottomAnchor, 10.0)
      .anchorWidth(150.0)
      .anchorHeight(44.0)
      .anchorCenterXToSuperview()
    
    buttonsStackView
      .anchorTop(colorPickerView.bottomAnchor, 10.0)
      .anchorLeft(qtyStackView.leftAnchor, 0.0)
      .anchorRight(qtyStackView.rightAnchor, 0.0)
      .anchorHeight(44.0)
      .anchorBottom(bottomAnchor, 10.0)
  }
  
  override func configureViews() {
    backgroundColor = .white
    
    titleLabel.font = .systemFont(ofSize: 19.0)
    titleLabel.textAlignment = .center
    
    qtyStackView.axis = .horizontal
    qtyStackView.alignment = .fill
    qtyStackView.distribution = .fillProportionally
    
    priceLabel.font = .systemFont(ofSize: 17.0)
    priceLabel.textAlignment = .right
    
    buyButton.setTitle(AppDefaults.Strings.Button.toCartButton, for: .normal)
    buyButton.backgroundColor = AppDefaults.Colors.buttons
    
    favouritesButton.setTitle(AppDefaults.Strings.Button.followButton, for: .normal)
    favouritesButton.backgroundColor = AppDefaults.Colors.buttons
    
    buttonsStackView.spacing = 20.0
    buttonsStackView.axis = .horizontal
    buttonsStackView.alignment = .fill
    buttonsStackView.distribution = .fillEqually
    
    ratingView.isActive = false
  }
}
