//
//  CartManager.swift
//  OrgTech
//
//  Created by Maksym Balukhtin on 29.04.2020.
//  Copyright © 2020 Maksym Balukhtin. All rights reserved.
//

import Foundation

class CartManager {
  static let shared = CartManager()
  
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
  
  func totalPrice() -> Int? {
    guard !products.isEmpty else { return nil }
    var totalPrice = 0
    products.forEach {
      totalPrice += ($0.price?.value ?? -1) * ($0.quantity?.intValue ?? -1)
    }
    return totalPrice
  }
  
  func empty() {
    products.removeAll()
    NotificationCenter.default.post(name: .cartEmptied, object: nil)
    sendNotifications()
  }
  
  private func sendNotifications() {
    NotificationCenter.default.post(name: .itemAddedToCart,
    object: nil,
    userInfo: [AppDefaults.Strings.Keys.cartCount: products.count])
  }
}
