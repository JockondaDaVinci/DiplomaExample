//
//  FavouritesInteractor.swift
//  OrgTech
//
//  Created by Maksym Balukhtin on 01.05.2020.
//  Copyright © 2020 Maksym Balukhtin. All rights reserved.
//

import Foundation

protocol FavouritesPresenterToInteractor {
  func obtainData()
  func removeItems(_ items: [ShortProductModel])
  func toCart(_ items: [ShortProductModel])
}


final class FavouritesInteractor {
  var presenter: FavouritesInteractorToPresenter?
  var favManager = FavouritesManager.shared
}


extension FavouritesInteractor: FavouritesPresenterToInteractor {
  func obtainData() {
    presenter?.onInteractorSuccess(favManager.products)
  }
  
  func removeItems(_ items: [ShortProductModel]) {
    items.forEach {
      favManager.add($0)
    }
    
    presenter?.onInteractorSuccess(favManager.products)
  }
  
  func toCart(_ items: [ShortProductModel]) {
    items.forEach {
      favManager.toCart($0)
    }
    
    presenter?.onInteractorSuccess(favManager.products)
  }
}
