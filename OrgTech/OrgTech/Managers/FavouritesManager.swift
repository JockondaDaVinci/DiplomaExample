//
//  FavouritesManager.swift
//  OrgTech
//
//  Created by Maksym Balukhtin on 01.05.2020.
//  Copyright © 2020 Maksym Balukhtin. All rights reserved.
//

import Foundation

class FavouritesManager {
  static let shared = FavouritesManager()
  
  var products = [ShortProductModel]()
  
  func add(_ product: ShortProductModel) {
    if products.contains(where: { $0 == product }) {
      products.removeAll { $0.id == product.id }
      sendNotifications()
      return
    }
    products.append(product)
    sendNotifications()
  }
  
  func toCart(_ product: ShortProductModel) {
    CartManager.shared.add(product)
    products.removeAll { $0.id == product.id }
    sendNotifications()
  }
  
  private func sendNotifications() {
    NotificationCenter.default.post(name: .itemAddedToFavourites,
    object: nil,
    userInfo: [AppDefaults.Strings.Keys.favouritesCount: products.count])
  }
}
