//
//  ReviewCellView.swift
//  OrgTech
//
//  Created by Maksym Balukhtin on 28.04.2020.
//  Copyright © 2020 Maksym Balukhtin. All rights reserved.
//

import UIKit

final class ReviewCellView: BuildableView {
  //MARK: Subviews
  private let headerStackView = UIStackView()
  let authorNameLabel = UILabel()
  let reviewTextLabel = UILabel()
  let ratingView = RatingView()
  
  override func addViews() {
    //add subviews into array
    [authorNameLabel, UIView(), ratingView].forEach {
      headerStackView.addArrangedSubview($0)
    }
    
    [headerStackView, reviewTextLabel].forEach{addSubview($0)}
  }
  
  override func anchorViews() {
    headerStackView
      .anchorTop(topAnchor, 5.0)
      .anchorLeft(leftAnchor, 10.0)
      .anchorRight(rightAnchor, 10.0)
      .anchorHeight(20.0)
    
    reviewTextLabel
      .anchorTop(headerStackView.bottomAnchor, 5.0)
      .anchorLeft(leftAnchor, 5.0)
      .anchorRight(rightAnchor, 5.0)
      .anchorBottom(bottomAnchor, 5.0)
  }
  
  override func configureViews() {
    backgroundColor = .white
    ratingView.isActive = false
    
    headerStackView.axis = .horizontal
    headerStackView.alignment = .fill
    headerStackView.distribution = .fillProportionally
    
    reviewTextLabel.numberOfLines = 0
    reviewTextLabel.font = .systemFont(ofSize: 14.0)
  }
}
