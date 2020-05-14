//
//  TextField.swift
//  OrgTech
//
//  Created by Maksym Balukhtin on 29.04.2020.
//  Copyright © 2020 Maksym Balukhtin. All rights reserved.
//

import UIKit

final class TextField: UITextField {
  var viewUnderline = UIView()
  var errorLabel = UILabel()
  
  var errorUnderlineColor: UIColor? = .red
  var editingUnderlineColor: UIColor? = .black
  var inactiveUnderlineColor: UIColor? = .lightGray
  
  @objc func injected() {
    subviews.forEach{
      $0.removeConstraints($0.constraints)
      $0.removeFromSuperview()
    }
    addViews()
    anchorViews()
    configureViews()
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    addViews()
    anchorViews()
    configureViews()
  }
  
  @available(*, unavailable) required init?(coder aDecoder: NSCoder) {
    fatalError("required init not implemented")
  }
  
  private func addViews() {
    [viewUnderline, errorLabel].forEach {
      addSubview($0)
    }
  }
  
  private func anchorViews() {
    viewUnderline
      .anchorBottom(bottomAnchor, 7)
      .anchorLeft(leftAnchor, 0)
      .anchorRight(rightAnchor, 0)
      .anchorHeight(2)
    
    errorLabel
      .anchorTop(viewUnderline.bottomAnchor, 0)
      .anchorLeft(leftAnchor, 0)
      .anchorRight(rightAnchor, 0)
  }
  
  private func configureViews() {
    delegate = self
    tintColor = .black
    clipsToBounds = false
    rightViewMode = .always
    borderStyle = .none
    viewUnderline.backgroundColor = .black
    
    errorLabel.textColor = errorUnderlineColor
    errorLabel.textAlignment = .left
    errorLabel.font = .systemFont(ofSize: 12.0)
  }
}

extension TextField: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    if let _textField = textField.superview?.viewWithTag(textField.tag + 1) as? TextField {
      _textField.becomeFirstResponder()
    } else if let _textView = textField.superview?.superview?.viewWithTag(textField.tag + 1) as? TextView {
      _textView.becomeFirstResponder()
    } else {
      textField.resignFirstResponder()
    }
    return false
  }
}

// Content insets
extension TextField {
  enum Constants {
    static let sideInsets = UIEdgeInsets(top: 0, left: 0, bottom: 6, right: 20)
  }
  
  override func textRect(forBounds bounds: CGRect) -> CGRect {
    return bounds.inset(by: Constants.sideInsets)
  }
  
  override func editingRect(forBounds bounds: CGRect) -> CGRect {
    return bounds.inset(by: Constants.sideInsets)
  }
  
  override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
    return bounds.inset(by: Constants.sideInsets)
  }
  
  override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
    return CGRect(x: bounds.size.width - 20, y: 20, width: 20, height: 20)
  }
  
  override func caretRect(for position: UITextPosition) -> CGRect {
    let rect = super.caretRect(for: position)
    return CGRect(x: rect.origin.x, y: rect.origin.y, width: 2, height: 24)
  }
}
