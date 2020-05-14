//
//  UIImage+Extensions.swift
//  OrgTech
//
//  Created by Maksym Balukhtin on 22.04.2020.
//  Copyright © 2020 Maksym Balukhtin. All rights reserved.
//

import UIKit

extension UIImage {
  enum TabItem: String {
    case home = "home"
    case menu = "menu"
    case cart = "cart"
    case search = "search"
  }
  
  convenience init?(_ item: TabItem) {
    self.init(named: item.rawValue)
  }
  
  func resized(to newWidth: CGFloat) -> UIImage? {
    let scale = newWidth / size.width
    let newHeight = size.height * scale
    
    UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
    self.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
  
    return newImage
  }
}
