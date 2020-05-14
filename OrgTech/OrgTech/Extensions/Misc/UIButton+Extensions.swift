//
//  UIButton+Extensions.swift
//  OrgTech
//
//  Created by Maksym Balukhtin on 02.05.2020.
//  Copyright © 2020 Maksym Balukhtin. All rights reserved.
//

import UIKit

extension UIButton {
  open override var isEnabled: Bool {
    didSet {
      alpha = isEnabled ? 1.0 : 0.5
    }
  }
}
