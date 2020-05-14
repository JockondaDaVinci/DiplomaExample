//
//  MenuInteractor.swift
//  OrgTech
//
//  Created by Maksym Balukhtin on 22.04.2020.
//  Copyright © 2020 Maksym Balukhtin. All rights reserved.
//

import Foundation

protocol MenuPresenterToInteractor {
  func getCategories()
}


final class MenuInteractor {
  var presenter: MenuInteractorToPresenter?
}


extension MenuInteractor: MenuPresenterToInteractor {
  func getCategories() {
    NetworkingManager.shared.startGetTask(forURL: Categories.main, object: WrapperModel<CategoryModel>.self) { [unowned self] data, error in
    if let error = error {
      self.presenter?.onInteractorError(error)
      return
    }
    
    guard let model = data else { return }
    self.presenter?.onInteractorSuccess(model)
    }
  }
}
