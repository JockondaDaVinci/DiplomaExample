//
//  CartInteractor.swift
//  OrgTech
//
//  Created by Maksym Balukhtin on 22.04.2020.
//  Copyright © 2020 Maksym Balukhtin. All rights reserved.
//

import Foundation

protocol CartPresenterToInteractor {
  func observeEmptyCart()
  func obtainData()
  func removeItems(_ items: [ShortProductModel])
}


final class CartInteractor {
  var presenter: CartInteractorToPresenter?
  var cartManager = CartManager.shared
}


extension CartInteractor: CartPresenterToInteractor {
  func observeEmptyCart() {
    NotificationCenter.default.addObserver(forName: .cartEmptied, object: nil, queue: .main) { [unowned self] _ in
      self.presenter?.onInteractorSuccess(self.cartManager.products)
    }
  }
  
  func obtainData() {
    presenter?.onInteractorSuccess(cartManager.products)
  }
  
  func removeItems(_ items: [ShortProductModel]) {
    items.forEach {
      cartManager.add($0)
    }
    
    presenter?.onInteractorSuccess(cartManager.products)
  }
}
