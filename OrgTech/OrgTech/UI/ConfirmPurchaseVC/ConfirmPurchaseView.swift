//
//  ConfirmPurchaseView.swift
//  OrgTech
//
//  Created by Maksym Balukhtin on 29.04.2020.
//  Copyright © 2020 Maksym Balukhtin. All rights reserved.
//

import UIKit

class ConfirmPurchaseView: BuildableView {
  //MARK: Subviews
  let titleLabel = UILabel()
  let emailTextField = TextField()
  let nameTextField = TextField()
  let addressTextField = TextField()
  let deliveryTypeTextField = TextField()
  let confirmButton = UIButton()
  let pickerView = UIPickerView()
  
  var _buttonBottom: NSLayoutConstraint?
  
  override func addViews() {
    //add subviews into array
    [titleLabel, emailTextField, nameTextField, addressTextField, deliveryTypeTextField, confirmButton].forEach{addSubview($0)}
  }
  
  override func anchorViews() {
    titleLabel
      .anchorTop(topAnchor, 10.0)
      .anchorLeft(leftAnchor, 20.0)
      .anchorRight(rightAnchor, 20.0)
    
    emailTextField
      .anchorTop(titleLabel.bottomAnchor, 10.0)
      .anchorLeft(titleLabel.leftAnchor, 0.0)
      .anchorRight(titleLabel.rightAnchor, 0.0)
      .anchorHeight(44.0)
    
    nameTextField
      .anchorTop(emailTextField.bottomAnchor, 10.0)
      .anchorLeft(titleLabel.leftAnchor, 0.0)
      .anchorRight(titleLabel.rightAnchor, 0.0)
      .anchorEqualHeight(emailTextField.heightAnchor)
    
    addressTextField
      .anchorTop(nameTextField.bottomAnchor, 10.0)
      .anchorLeft(titleLabel.leftAnchor, 0.0)
      .anchorRight(titleLabel.rightAnchor, 0.0)
      .anchorEqualHeight(emailTextField.heightAnchor)
    
    deliveryTypeTextField
      .anchorTop(addressTextField.bottomAnchor, 10.0)
      .anchorLeft(titleLabel.leftAnchor, 0.0)
      .anchorRight(titleLabel.rightAnchor, 0.0)
      .anchorEqualHeight(emailTextField.heightAnchor)
    
    _buttonBottom = confirmButton._anchorBottom(bottomAnchor, 0.0)
    confirmButton
      .anchorHeight(44.0)
      .anchorEqualWidth(widthAnchor)
  }
  
  override func configureViews() {
    backgroundColor = .white
    
    confirmButton.setTitle(AppDefaults.Strings.Button.confirmButton, for: .normal)
    confirmButton.backgroundColor = AppDefaults.Colors.buttons
    confirmButton.isEnabled = false
    
    emailTextField.placeholder = AppDefaults.Strings.Placeholder.TextField.email
    nameTextField.placeholder = AppDefaults.Strings.Placeholder.TextField.name
    addressTextField.placeholder = AppDefaults.Strings.Placeholder.TextField.address
    deliveryTypeTextField.placeholder = AppDefaults.Strings.Placeholder.TextField.deliveryType
    
    doneButton.setTitle(AppDefaults.Strings.Button.done, for: .normal)
    doneButton.setTitleColor(.black, for: .normal)
    deliveryTypeTextField.inputAccessoryView = toolBar
    deliveryTypeTextField.inputView = pickerView
    
    titleLabel.font = .systemFont(ofSize: 15.0)
    titleLabel.textAlignment = .left
    titleLabel.numberOfLines = 0
    titleLabel.textColor = .lightGray
    
    [emailTextField, nameTextField, addressTextField, deliveryTypeTextField].enumerated().forEach {
      $0.element.tag = $0.offset
    }
    
    confirmButton.isEnabled = false
  }
}

