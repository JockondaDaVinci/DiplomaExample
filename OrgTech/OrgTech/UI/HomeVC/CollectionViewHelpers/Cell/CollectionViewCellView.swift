//
//  CollectionViewCellView.swift
//  OrgTech
//
//  Created by Maksym Balukhtin on 22.04.2020.
//  Copyright © 2020 Maksym Balukhtin. All rights reserved.
//

import UIKit

final class CollectionViewCellView: BuildableView {
  //MARK: Subviews
  let imageView = UIImageView()
  let titleLabel = UILabel()
  let priceLabel = UILabel()
  let specialOfferView = SpecialOfferView()
  
  override func addViews() {
    //add subviews into array
    [imageView, titleLabel, priceLabel, specialOfferView].forEach{addSubview($0)}
  }
  
  override func anchorViews() {
    imageView
      .anchorTop(topAnchor, 5.0)
      .anchorLeft(leftAnchor, 5.0)
      .anchorRight(rightAnchor, 5.0)
      .anchorEqualHeight(imageView.widthAnchor)
    
    titleLabel
      .anchorTop(imageView.bottomAnchor, 5.0)
      .anchorLeft(imageView.leftAnchor, 0.0)
      .anchorRight(imageView.rightAnchor, 0.0)
    
    priceLabel
      .anchorTop(titleLabel.bottomAnchor, 5.0)
      .anchorLeft(imageView.leftAnchor, 0.0)
      .anchorRight(imageView.rightAnchor, 0.0)
      .anchorBottom(bottomAnchor, 5.0)
      .anchorHeight(20.0)
    
    specialOfferView
      .anchorTop(topAnchor, -5)
      .anchorLeft(leftAnchor, -5)
      .anchorHeight(30.0)
      .anchorEqualWidth(specialOfferView.heightAnchor)
  }
  
  override func configureViews() {
    backgroundColor = .white
    imageView.contentMode = .scaleAspectFit
    
    [titleLabel, priceLabel].forEach {
      $0.textColor = AppDefaults.Colors.Text.default
      $0.textAlignment = .center
      $0.numberOfLines = 0
    }
    
    titleLabel.adjustsFontSizeToFitWidth = true
    titleLabel.minimumScaleFactor = 0.5
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    layer.cornerRadius = 10
    
    layer.sublayers?.forEach {
      if $0 is CAShapeLayer {
        $0.removeFromSuperlayer()
      }
    }
    
    let shadowLayer: CAShapeLayer = CAShapeLayer()
    shadowLayer.path = UIBezierPath(roundedRect: frame, cornerRadius: 10).cgPath
    shadowLayer.fillColor = backgroundColor?.cgColor
    shadowLayer.shadowColor = UIColor.lightGray.cgColor
    shadowLayer.shadowPath = shadowLayer.path
    shadowLayer.shadowOffset = CGSize(width: 0.0, height: 0.0)
    shadowLayer.shadowOpacity = 0.7
    shadowLayer.shadowRadius = 1.5
    layer.insertSublayer(shadowLayer, at: 0)
  }
}

final class SpecialOfferView: BuildableView {
  enum OfferType {
    case top
    case sale(Int)
    case count(Int)
  }
  
  private let label = UILabel()
  
  var type: OfferType = .top {
    didSet {
      switch type {
      case .sale(let value):
        backgroundColor = AppDefaults.Colors.buttons
        label.text = "\(value)%"
        label.isHidden = false
      case .count(let value):
        backgroundColor = AppDefaults.Colors.buttons
        label.text = "\(value)"
        label.isHidden = false
      default: break
      }
    }
  }
  
  override func addViews() {
    addSubview(label)
  }
  
  override func anchorViews() {
    label.fillSuperview()
  }
  
  override func configureViews() {
    label.font = .systemFont(ofSize: 10.0)
    label.textAlignment = .center
    label.textColor = .white
    label.isHidden = true
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    layer.cornerRadius = frame.height / 2
  }
}
