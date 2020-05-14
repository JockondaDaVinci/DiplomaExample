//
//  SliderItemView.swift
//  OrgTech
//
//  Created by Maksym Balukhtin on 16.02.2020.
//  Copyright © 2020 Maksym Balukhtin. All rights reserved.
//

import UIKit

class SliderItemView: BuildableView {
  //MARK: - Private
  private let imageView = UIImageView()
  private let titleLabel = UILabel()
  
  //MARK: - Public
  var title: String = "" {
    didSet {
      titleLabel.text = title
    }
  }
  
  //MARK: - Overrides
  override func addViews() {
    [imageView, titleLabel].forEach {
      addSubview($0)
    }
  }
  
  override func anchorViews() {
    imageView.fillSuperview()
    
    titleLabel
      .anchorLeft(imageView.leftAnchor, 10.0)
      .anchorRight(imageView.rightAnchor, 10.0)
      .anchorBottom(imageView.bottomAnchor, 10.0)
      .anchorHeight(25.0)
  }
  
  override func configureViews() {
    imageView.contentMode = .scaleAspectFit
    imageView.clipsToBounds = true
    
    titleLabel.font = .systemFont(ofSize: 14.0, weight: .regular)
    titleLabel.textColor = AppDefaults.Colors.white
    titleLabel.textAlignment = .left
  }
}
