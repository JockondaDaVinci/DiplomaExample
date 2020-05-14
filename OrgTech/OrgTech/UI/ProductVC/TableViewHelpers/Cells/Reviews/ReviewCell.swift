//
//  ReviewCell.swift
//  OrgTech
//
//  Created by Maksym Balukhtin on 28.04.2020.
//  Copyright © 2020 Maksym Balukhtin. All rights reserved.
//

import Foundation

final class ReviewCell: BuildableTableViewCell<ReviewCellView, ReviewModel> {
  override func config(with object: ReviewModel) {
    mainView.authorNameLabel.text = object.autor
    mainView.ratingView.rating = object.rating?.value ?? 0
    mainView.reviewTextLabel.text = object.review
  }
}
