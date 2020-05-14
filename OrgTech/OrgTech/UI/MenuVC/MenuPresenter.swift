//
//  MenuPresenter.swift
//  OrgTech
//
//  Created by Maksym Balukhtin on 22.04.2020.
//  Copyright © 2020 Maksym Balukhtin. All rights reserved.
//

import Foundation

protocol MenuViewToPresenter: AnyObject {
  func onViewLoaded()
  func onViewEvent(_ event: MenuViewEvent)
}

protocol MenuInteractorToPresenter {
  func onInteractorError(_ error: Error)
  func onInteractorSuccess(_ data: WrapperModel<CategoryModel>)
}

protocol MenuInputs: Inputs {
  
}


final class MenuPresenter: MenuInputs {
  weak var view: MenuPresenterToView?
  var interactor: MenuPresenterToInteractor?
  var router: MenuRouter.Routes?
  
  //Module input
}


extension MenuPresenter: MenuViewToPresenter {
  func onViewLoaded() {
    view?.setupInitialState()
    interactor?.getCategories()
  }
  
  func onViewEvent(_ event: MenuViewEvent) {
    switch event {
    case .onTableViewEvent(let tableViewEvent):
      switch tableViewEvent {
      case .onCategoryAction(let categoryID):
        if categoryID.doubleValue < 0.0 {
          router?.toFavourites()
        } else {
          router?.toCategory(withID: categoryID)
        }
      }
    }
  }
}


extension MenuPresenter: MenuInteractorToPresenter {
  func onInteractorError(_ error: Error) {
    debugPrint(error)
  }
  
  func onInteractorSuccess(_ data: [CategoryModel]) {
    view?.populateData(data)
  }
}
