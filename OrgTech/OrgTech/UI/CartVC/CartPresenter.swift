//
//  CartPresenter.swift
//  OrgTech
//
//  Created by Maksym Balukhtin on 22.04.2020.
//  Copyright © 2020 Maksym Balukhtin. All rights reserved.
//

import Foundation

protocol CartViewToPresenter {
  func onViewLoaded()
  func onViewAppeared()
  func onViewEvent(_ event: CartViewEvent)
}

protocol CartInteractorToPresenter {
  func onInteractorSuccess(_ data: [ShortProductModel])
}

protocol CartInputs: Inputs {
  
}


final class CartPresenter: CartInputs {
  weak var view: CartPresenterToView?
  var interactor: CartPresenterToInteractor?
  var router: CartRouter.Routes?
  
  //Module input
}


extension CartPresenter: CartViewToPresenter {
  func onViewLoaded() {
    interactor?.observeEmptyCart()
  }
  
  func onViewAppeared() {
    view?.setupInitialState()
    interactor?.obtainData()
  }
  
  func onViewEvent(_ event: CartViewEvent) {
    switch event {
    case .onProceedButtonAction:
      router?.toConfirm()
    case .onTableViewEvent(let tableViewEvent):
      switch tableViewEvent {
      case .onItemDelete(let item):
        interactor?.removeItems([item])
      }
    }
  }
}


extension CartPresenter: CartInteractorToPresenter {
  func onInteractorSuccess(_ data: [ShortProductModel]) {
    view?.updateUI(with: data)
  }
}
