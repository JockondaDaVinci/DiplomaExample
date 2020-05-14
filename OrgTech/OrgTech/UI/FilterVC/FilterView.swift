//
//  FilterView.swift
//  OrgTech
//
//  Created by Maksym Balukhtin on 30.04.2020.
//  Copyright © 2020 Maksym Balukhtin. All rights reserved.
//

import UIKit

class FilterView: BuildableView {
  //MARK: Subviews
  private let globalStackView = UIStackView()
  let priceStackView = UIStackView()
  private let priceLabel = UILabel()
  let pricePickerView = RangeSlider(frame: .zero)
  private let minMaxPriceStackView = UIStackView()
  let minPriceLabel = UILabel()
  let maxPriceLabel = UILabel()
  
  let colorStackView = UIStackView()
  private let colorLabel = UILabel()
  let colorPickerView = ColorPickerView()
  
  let brandsStackView = UIStackView()
  private let brandsLabel = UILabel()
  let brandsTextField = TextField()
  let pickerView = UIPickerView()
  
  let confirmButton = UIButton()
  var _buttonBottom: NSLayoutConstraint?
  
  override func addViews() {
    //add subviews into array
    [minPriceLabel, UIView(), maxPriceLabel].forEach {
      minMaxPriceStackView.addArrangedSubview($0)
    }
    
    [priceLabel, pricePickerView, minMaxPriceStackView].forEach {
      priceStackView.addArrangedSubview($0)
    }
    
    [colorLabel, colorPickerView].forEach {
      colorStackView.addArrangedSubview($0)
    }
    
    [brandsLabel, brandsTextField].forEach {
      brandsStackView.addArrangedSubview($0)
    }
    
    [priceStackView, colorStackView, brandsStackView, UIView()].forEach {
      globalStackView.addArrangedSubview($0)
    }
    
    [globalStackView, confirmButton].forEach{addSubview($0)}
  }
  
  override func anchorViews() {
    confirmButton
    .anchorLeft(leftAnchor, 0.0)
    .anchorRight(rightAnchor, 0.0)
    .anchorHeight(44.0)
    
    globalStackView
      .anchorTop(safeAreaLayoutGuideAnyIOS.topAnchor, 10.0)
      .anchorLeft(leftAnchor, 20.0)
      .anchorRight(rightAnchor, 20.0)
      .anchorBottom(confirmButton.topAnchor, 10.0)
    
    minMaxPriceStackView
      .anchorHeight(10.0)
    
    priceStackView
      .anchorHeight(80.0)
    
    colorStackView
      .anchorEqualHeight(priceStackView.heightAnchor)
    
    brandsStackView
      .anchorEqualHeight(priceStackView.heightAnchor)
    
    _buttonBottom = confirmButton
      ._anchorBottom(safeAreaLayoutGuideAnyIOS.bottomAnchor, 0.0)
    
    [pricePickerView, colorPickerView, brandsTextField].forEach {
      $0.anchorHeight(44.0)
    }
  }
  
  override func configureViews() {
    backgroundColor = .white
    
    [priceLabel, colorLabel, brandsLabel].forEach {
      $0.textAlignment = .left
      $0.font = .systemFont(ofSize: 14.0)
      $0.textColor = .lightGray
    }
    
    priceLabel.text = AppDefaults.Strings.Placeholder.price
    colorLabel.text = AppDefaults.Strings.Placeholder.color
    brandsLabel.text = AppDefaults.Strings.Placeholder.brand
    
    globalStackView.spacing = 10.0
    globalStackView.axis = .vertical
    globalStackView.alignment = .fill
    globalStackView.distribution = .fill
    
    minMaxPriceStackView.axis = .horizontal
    minMaxPriceStackView.alignment = .fill
    minMaxPriceStackView.distribution = .fillProportionally
    
    [minPriceLabel, maxPriceLabel].forEach {
      $0.font = .systemFont(ofSize: 12.0)
      $0.textColor = .lightGray
    }
    
    minPriceLabel.textAlignment = .left
    maxPriceLabel.textAlignment = .right
    
    [priceStackView, colorStackView, brandsStackView].forEach {
      $0.spacing = 5.0
      $0.axis = .vertical
      $0.alignment = .fill
      $0.distribution = .fillProportionally
    }
    
    doneButton.setTitle(AppDefaults.Strings.Button.done, for: .normal)
    doneButton.setTitleColor(.black, for: .normal)
    brandsTextField.inputAccessoryView = toolBar
    brandsTextField.inputView = pickerView
    brandsTextField.placeholder = AppDefaults.Strings.Placeholder.TextField.brand
    
    confirmButton.setTitle(AppDefaults.Strings.Button.confirmButton, for: .normal)
    confirmButton.backgroundColor = AppDefaults.Colors.buttons
  }
}


