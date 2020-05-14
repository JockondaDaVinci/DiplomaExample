//
//  UIView+Extensions.swift
//  OrgTech
//
//  Created by Maksym Balukhtin on 22.04.2020.
//  Copyright © 2020 Maksym Balukhtin. All rights reserved.
//

import UIKit

extension UIView {
  static var reuseId: String {
    return String(describing: self)
  }
}
