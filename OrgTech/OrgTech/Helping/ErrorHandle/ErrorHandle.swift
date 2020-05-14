//
//  ErrorHandle.swift
//  OrgTech
//
//  Created by Maksym Balukhtin on 02.05.2020.
//  Copyright © 2020 Maksym Balukhtin. All rights reserved.
//

import UIKit

protocol ErrorHandle {
  var viewUnderline: UIView { get set }
  var errorLabel: UILabel { get set }
  var errorUnderlineColor: UIColor? { get set }
  var editingUnderlineColor: UIColor? { get set }
  var inactiveUnderlineColor: UIColor? { get set }
  
  func showValidationErrorMessage(_ error: String)
  func setValid()
}

extension TextField: ErrorHandle { }
extension TextView: ErrorHandle { }

extension ErrorHandle {
  func showValidationErrorMessage(_ error: String) {
    errorLabel.text = error
    viewUnderline.backgroundColor = errorUnderlineColor
  }
  
  func setValid() {
    errorLabel.text = nil
    viewUnderline.backgroundColor = editingUnderlineColor
  }
}

