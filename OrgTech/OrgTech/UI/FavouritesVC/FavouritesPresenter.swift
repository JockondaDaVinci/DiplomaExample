//
//  FavouritesPresenter.swift
//  OrgTech
//
//  Created by Maksym Balukhtin on 01.05.2020.
//  Copyright © 2020 Maksym Balukhtin. All rights reserved.
//

import Foundation

protocol FavouritesViewToPresenter {
  func onViewFirstWillAppear()
  func onViewEvent(_ event: FavouritesViewEvent)
}

protocol FavouritesInteractorToPresenter {
  func onInteractorSuccess(_ data: [ShortProductModel])
}

protocol FavouritesInputs: Inputs {
  
}


final class FavouritesPresenter: FavouritesInputs {
  weak var view: FavouritesPresenterToView?
  var interactor: FavouritesPresenterToInteractor?
  var router: FavouritesRouter.Routes?
  
  //Module input
}


extension FavouritesPresenter: FavouritesViewToPresenter {
  func onViewFirstWillAppear() {
    view?.setupInitialState()
    interactor?.obtainData()
  }
  
  func onViewEvent(_ event: FavouritesViewEvent) {
    switch event {
    case .onTableViewEvent(let tableViewEvent):
      switch tableViewEvent {
      case .onItemDelete(let product):
        interactor?.removeItems([product])
      case .onItemToCart(let product):
        interactor?.toCart([product])
      }
    }
  }
}


extension FavouritesPresenter: FavouritesInteractorToPresenter {
  func onInteractorSuccess(_ data: [ShortProductModel]) {
    view?.populateData(data)
  }
}
