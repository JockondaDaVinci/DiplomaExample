//
//  CategoryInteractor.swift
//  OrgTech
//
//  Created by Maksym Balukhtin on 29.04.2020.
//  Copyright © 2020 Maksym Balukhtin. All rights reserved.
//

import Foundation

protocol CategoryPresenterToInteractor {
  func getCategoryContents(byID id: String?)
}


final class CategoryInteractor {
  var presenter: CategoryInteractorToPresenter?
}


extension CategoryInteractor: CategoryPresenterToInteractor {
  func getCategoryContents(byID id: String?) {
    guard let id = id else { return }
    NetworkingManager.shared
      .startGetTask(forURL: Categories.getCategory(byID: id), object: WrapperModel<CategoryContentModel>.self) { [unowned self] data, error in
        if let error = error {
          self.presenter?.onInteractorError(error)
          return
        }
        
        guard let model = data else { return }
        self.presenter?.onInteractorSuccess(model)
    }
  }
}
