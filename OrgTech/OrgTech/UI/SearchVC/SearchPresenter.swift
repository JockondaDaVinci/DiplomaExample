//
//  SearchPresenter.swift
//  OrgTech
//
//  Created by Maksym Balukhtin on 22.04.2020.
//  Copyright © 2020 Maksym Balukhtin. All rights reserved.
//

import Foundation

protocol SearchViewToPresenter {
  func onViewLoaded()
  func onViewEvent(_ event: SearchViewEvent)
}

protocol SearchInteractorToPresenter {
  func onInteractorError(_ error: Error)
  func onInteractorSuccess(_ data: [ShortProductModel])
}

protocol SearchInputs: Inputs {
  
}


final class SearchPresenter: SearchInputs {
  weak var view: SearchPresenterToView?
  var interactor: SearchPresenterToInteractor?
  var router: SearchRouter.Routes?
  
  //Module input
}


extension SearchPresenter: SearchViewToPresenter {
  func onViewLoaded() {
    view?.setupInitialState()
  }
  
  func onViewEvent(_ event: SearchViewEvent) {
    switch event {
    case .onSeacrhEvent(let searchEvent):
      switch searchEvent {
      case .onSearchButtonAction(let query):
        interactor?.performSearch(by: query)
      case .onCancelButtonAction:
        view?.clear(true)
      }
    case .onTableViewEvent(let tableViewEvent):
      switch tableViewEvent {
      case .onItemsSelected(let productID):
        router?.toProduct(withID: productID)
      }
    }
  }
}


extension SearchPresenter: SearchInteractorToPresenter {
  func onInteractorSuccess(_ data: [ShortProductModel]) {
    view?.populateSearchData(data)
  }
  
  func onInteractorError(_ error: Error) {
    debugPrint(error)
    view?.showError()
  }
}
