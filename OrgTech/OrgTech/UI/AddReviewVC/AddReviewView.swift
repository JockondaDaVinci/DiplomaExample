//
//  AddReviewView.swift
//  OrgTech
//
//  Created by Maksym Balukhtin on 29.04.2020.
//  Copyright © 2020 Maksym Balukhtin. All rights reserved.
//

import UIKit

class AddReviewView: BuildableView {
  //MARK: Subviews
  private let descriptionLabel = UILabel()
  private let headerStackView = UIStackView()
  let nameTextField = TextField()
  let ratingView = RatingView()
  let reviewTextView = TextView()
  private let charCountLabel = UILabel()
  let submitButton = UIButton()
  
  var _buttonBottom: NSLayoutConstraint?
  
  override func addViews() {
    //add subviews into array
    [nameTextField, UIView(), ratingView].forEach {
      headerStackView.addArrangedSubview($0)
    }
    
    [descriptionLabel, headerStackView, reviewTextView, charCountLabel, submitButton].forEach{addSubview($0)}
  }
  
  override func anchorViews() {
    descriptionLabel
      .anchorTop(topAnchor, 20.0)
      .anchorLeft(leftAnchor, 20.0)
      .anchorRight(rightAnchor, 20.0)
    
    headerStackView
      .anchorTop(descriptionLabel.bottomAnchor, 10.0)
      .anchorLeft(descriptionLabel.leftAnchor, 0.0)
      .anchorRight(descriptionLabel.rightAnchor, 0.0)
      .anchorHeight(44.0)
    
    reviewTextView
      .anchorTop(headerStackView.bottomAnchor, 10.0)
      .anchorLeft(headerStackView.leftAnchor, 0.0)
      .anchorRight(headerStackView.rightAnchor, 0.0)
      .anchorHeight(200.0)
    
    nameTextField.anchorWidth(200.0)
    
    charCountLabel
      .anchorTop(reviewTextView.bottomAnchor, 5.0)
      .anchorRight(reviewTextView.rightAnchor, 0.0)
    
    submitButton
      .anchorLeft(leftAnchor, 0.0)
      .anchorRight(rightAnchor, 0.0)
      .anchorHeight(44.0)
      
    _buttonBottom = submitButton._anchorBottom(bottomAnchor, 0.0)
  }
  
  override func configureViews() {
    backgroundColor = .white
    
    [descriptionLabel, charCountLabel].forEach {
      $0.textColor = .lightGray
    }
    
    descriptionLabel.font = .systemFont(ofSize: 15.0)
    descriptionLabel.numberOfLines = 0
    descriptionLabel.text = AppDefaults.Strings.Label.reviewTip
    descriptionLabel.textAlignment = .center
    
    charCountLabel.font = .systemFont(ofSize: 12.0)
    charCountLabel.text = "0/150"
    
    headerStackView.axis = .horizontal
    headerStackView.distribution = .equalSpacing
    headerStackView.alignment = .center
    
    submitButton.setTitle(AppDefaults.Strings.Button.confirmButton, for: .normal)
    submitButton.backgroundColor = AppDefaults.Colors.buttons
    submitButton.isEnabled = false

    nameTextField.placeholder = AppDefaults.Strings.Placeholder.TextField.name
    
    doneButton.setTitle(AppDefaults.Strings.Button.done, for: .normal)
    doneButton.setTitleColor(.black, for: .normal)
    reviewTextView.inputAccessoryView = toolBar
    reviewTextView.placeholder = AppDefaults.Strings.Placeholder.TextField.comment
    reviewTextView.charCountChanged = { [unowned self] count in
      self.charCountLabel.text = "\(count)/150"
    }
    
    [nameTextField, reviewTextView].enumerated().forEach {
      $0.element.tag = $0.offset
    }
  }
}
