//
//  UIImageView+Extensions.swift
//  OrgTech
//
//  Created by Maksym Balukhtin on 22.04.2020.
//  Copyright © 2020 Maksym Balukhtin. All rights reserved.
//

import UIKit

extension UIImageView {
  func downloaded(fromURL url: String) {
    if let cachedImageData = CacheManager.shared.cacheImage(nil, byKey: url) {
      self.image = UIImage(data: cachedImageData)
    } else {
      NetworkingManager.shared.downloadImage(forURL: url) { imageData, error in
        guard let data = imageData else { return }
        self.image = UIImage(data: data)
      }
    }
  }
}
