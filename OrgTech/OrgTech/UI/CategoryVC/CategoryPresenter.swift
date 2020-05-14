//
//  CategoryPresenter.swift
//  OrgTech
//
//  Created by Maksym Balukhtin on 29.04.2020.
//  Copyright © 2020 Maksym Balukhtin. All rights reserved.
//

import Foundation

protocol CategoryViewToPresenter {
  func onViewLoaded()
  func onViewEvent(_ event: CategoryViewEvent)
}

protocol CategoryInteractorToPresenter {
  func onInteractorError(_ error: Error)
  func onInteractorSuccess(_ data: [MainModelProtocol])
}

protocol CategoryInputs: Inputs {
  var categoryID: String? { get set }
}


final class CategoryPresenter: CategoryInputs {
  weak var view: CategoryPresenterToView?
  var interactor: CategoryPresenterToInteractor?
  var router: CategoryRouter.Routes?
  
  //Module input
  var categoryID: String?
}


extension CategoryPresenter: CategoryViewToPresenter {
  func onViewLoaded() {
    view?.setupInitialState()
    
    interactor?.getCategoryContents(byID: categoryID)
  }
  
  func onViewEvent(_ event: CategoryViewEvent) {
    switch event {
    case .onCollectionViewAction(let collectionViewEvent):
      switch collectionViewEvent {
      case .onCellAction(let productID):
        router?.toProduct(withID: productID)
      }
    case .onFilterButtonAction:
      guard let categoryID = categoryID else { return }
      router?.toFilter(withID: categoryID, delegate: self)
    }
  }
}


extension CategoryPresenter: CategoryInteractorToPresenter {
  func onInteractorSuccess(_ data: [MainModelProtocol]) {
    view?.populateData(data)
  }
  
  func onInteractorError(_ error: Error) {
    view?.setupEmptyData("")
  }
}

extension CategoryPresenter: FilterInputsDelegate {
  func filterDidReceiveFilteredItems(_ data: [MainModelProtocol]) {
    view?.populateData(data)
  }
  
  func filterDidReceiveError() {
    view?.setupEmptyData("Sorry, but nothing found by your filter options!")
  }
}
