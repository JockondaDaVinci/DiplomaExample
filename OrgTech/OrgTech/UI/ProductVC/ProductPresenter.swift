//
//  ProductPresenter.swift
//  OrgTech
//
//  Created by Maksym Balukhtin on 22.04.2020.
//  Copyright © 2020 Maksym Balukhtin. All rights reserved.
//

import Foundation

protocol ProductViewToPresenter {
  func onViewAppeared()
  func onViewLoaded()
  func onViewEvent(_ event: ProductViewEvent)
}

protocol ProductInteractorToPresenter {
  func onInteractorError(_ error: Error)
  func onInteractorSuccess(_ data: ProductModel)
}

protocol ProductInputs: Inputs {
  var productID: String? { get set }
}


final class ProductPresenter: ProductInputs {
  weak var view: ProductPresenterToView?
  var interactor: ProductPresenterToInteractor?
  var router: ProductRouter.Routes?
  
  var cartManager = CartManager.shared
  var favManager = FavouritesManager.shared
  
  //Module input
  var productID: String?
  var product: ProductModel?
}


extension ProductPresenter: ProductViewToPresenter {
  func onViewLoaded() {
    if let productID = productID {
      interactor?.getProduct(byID: productID)
    }
    view?.setupInitialState()
  }
  
  func onViewEvent(_ event: ProductViewEvent) {
    switch event {
    case .onTableViewEvent(let tableViewEvent):
      switch tableViewEvent {
      case .onAddReviewButtonAction:
        router?.toAddReview()
      case .onButtonsAction(let action):
        switch action {
        case .onBuyButtonAction(let product):
          cartManager.add(product)
          reloadData()
        case .onFavButtonAction(let product):
          favManager.add(product)
          reloadData()
        }
      }
    }
  }
  
  func reloadData() {
    let inCart = cartManager.products.contains(where: { $0.id == product?.productID })
    let followed = favManager.products.contains(where: { $0.id == product?.productID })
    
    view?.changeButtonsTitles(inCart, followed: followed)
  }
  
  func onViewAppeared() {
    reloadData()
  }
}

extension ProductPresenter: ProductInteractorToPresenter {
  func onInteractorError(_ error: Error) {
    debugPrint(error)
  }
  
  func onInteractorSuccess(_ data: ProductModel) {
    product = data
    view?.loadProductDetails(data)
    reloadData()
  }
}
