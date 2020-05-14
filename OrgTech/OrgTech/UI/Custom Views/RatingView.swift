//
//  RatingView.swift
//  OrgTech
//
//  Created by Maksym Balukhtin on 23.04.2020.
//  Copyright © 2020 Maksym Balukhtin. All rights reserved.
//

import UIKit

class RatingView: UIStackView {
  
  var isActive: Bool = true {
    didSet {
      ratingButtons.forEach {
        $0.isUserInteractionEnabled = isActive
      }
    }
  }
  
  public var ratingButtons = [UIButton]()
  
  var rating = 0 {
    didSet {
      updateButtonState()
    }
  }
  
  var starSize: CGSize = CGSize(width: 20.0, height: 20.0) {
    didSet {
      setupRatingButtons()
    }
  }
  
  var starCount: Int = 5 {
    didSet {
      setupRatingButtons()
    }
  }
  
  var eventHandler: ((Int) -> Void)?
  
  private func setupRatingButtons() {
    //reset buttons
    ratingButtons.forEach {
      removeArrangedSubview($0)
      $0.removeFromSuperview()
    }
    ratingButtons.removeAll()
    
    //create buttons
    for _ in 0 ..< starCount {
      let button = UIButton()
      
      //set images
      button.setImage(AppDefaults.Images.Rating.empty, for: .normal)
      button.setImage(AppDefaults.Images.Rating.filled, for: .selected)
      button.setImage(AppDefaults.Images.Rating.highlighted, for: .highlighted)
      button.setImage(AppDefaults.Images.Rating.highlighted, for: [.highlighted, .selected])
      
      
      button.translatesAutoresizingMaskIntoConstraints = false
      button.anchorHeight(starSize.height)
      button.anchorWidth(starSize.width)
      
      addArrangedSubview(button)
      
      button.addAction(for: .touchUpInside) { [unowned self] in
        self.ratingButtonTapped(button: button)
      }
      
      ratingButtons.append(button)
    }
    
    updateButtonState()
  }
  
  @objc func ratingButtonTapped(button: UIButton) {
    guard let index = ratingButtons.firstIndex(of: button) else {
      fatalError("The button \(button), is not is not in the array: \(ratingButtons)")
    }
    
    //finding the rating of the selected button
    let selectedRating = index + 1
    
    if selectedRating == rating {
      //reset rating
      rating = 0
    } else {
      //or set rating
      rating = selectedRating
    }
    
    eventHandler?(rating)
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupRatingButtons()
  }
  
  required init(coder: NSCoder) {
    super.init(coder: coder)
    setupRatingButtons()
  }
  
  public func updateButtonState(){
    ratingButtons.enumerated().forEach {
      $0.element.isSelected = $0.offset < rating
    }
  }
  
}
