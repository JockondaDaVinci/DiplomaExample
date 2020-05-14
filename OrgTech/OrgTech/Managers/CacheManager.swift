//
//  CacheManager.swift
//  OrgTech
//
//  Created by Maksym Balukhtin on 29.04.2020.
//  Copyright © 2020 Maksym Balukhtin. All rights reserved.
//

import Foundation

class CacheManager {
  static var shared = CacheManager()
  
  private var cache = NSCache<AnyObject, AnyObject>()
  
  @discardableResult
  func cacheImage(_ image: Data?, byKey key: String) -> Data? {
    if let imageFromCache = cache.object(forKey: key as AnyObject) as? Data {
      return imageFromCache
    } else {
      cache.setObject(image as AnyObject, forKey: key as AnyObject)
      return nil
    }
  }
}
