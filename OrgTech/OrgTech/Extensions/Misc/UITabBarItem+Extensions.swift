//
//  UITabBarItem+Extensions.swift
//  OrgTech
//
//  Created by Maksym Balukhtin on 22.04.2020.
//  Copyright © 2020 Maksym Balukhtin. All rights reserved.
//

import UIKit

extension UITabBarItem {
  convenience init(name: String, image: UIImage?) {
    self.init(title: name, image: image, selectedImage: image)
  }
}
