//
//  SecationHeaderCellView.swift
//  OrgTech
//
//  Created by Maksym Balukhtin on 28.04.2020.
//  Copyright © 2020 Maksym Balukhtin. All rights reserved.
//

import UIKit

final class SectionHeaderCellView: BuildableView {
  //MARK: Subviews
  let titleLabel = UILabel()
  let accessoryButton = UIButton()
  private let separatorView = UIView()
  
  override func addViews() {
    //add subviews into array
    [titleLabel, accessoryButton, separatorView].forEach{addSubview($0)}
  }
  
  override func anchorViews() {
    titleLabel
    .anchorCenterYToView(self)
    .anchorCenterXToView(self)
    
    accessoryButton
      .anchorHeight(20.0)
      .anchorEqualWidth(accessoryButton.heightAnchor)
      .anchorRight(rightAnchor, 20.0)
      .anchorCenterYToView(self)
    
    separatorView
      .anchorBottom(bottomAnchor, 0.0)
      .anchorLeft(leftAnchor, 10.0)
      .anchorRight(rightAnchor, 10.0)
      .anchorHeight(1.0)
  }
  
  override func configureViews() {
    backgroundColor = .white
    
    accessoryButton.setImage(AppDefaults.Images.Buttons.addButton, for: .normal)
    
    titleLabel.textColor = .black
    titleLabel.textAlignment = .center
    titleLabel.font = .systemFont(ofSize: 17.0)
    
    separatorView.backgroundColor = .lightGray
  }
}
