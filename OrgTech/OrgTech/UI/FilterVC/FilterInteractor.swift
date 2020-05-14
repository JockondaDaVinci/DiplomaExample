//
//  FilterInteractor.swift
//  OrgTech
//
//  Created by Maksym Balukhtin on 30.04.2020.
//  Copyright © 2020 Maksym Balukhtin. All rights reserved.
//

import Foundation

protocol FilterPresenterToInteractor {
  func getFilterParameters(forID id: String)
  func performFilter(byParametes parameters: FilterPostModel)
}


final class FilterInteractor {
  var presenter: FilterInteractorToPresenter?
  var networkManager = NetworkingManager.shared
}


extension FilterInteractor: FilterPresenterToInteractor {
  func getFilterParameters(forID id: String) {
    networkManager.startGetTask(forURL: Categories.getFilterParameters(forID: id), object: FilterGetModel.self) { [unowned self] data, error in
      if let error = error {
        self.presenter?.onInteractorError(error)
        return
      }
      
      guard let model = data else { return }
      self.presenter?.onInteractorGetFilterParameters(model)
    }
  }
  
  func performFilter(byParametes parameters: FilterPostModel) {
    networkManager
      .startPostTask(forURL: Product.filter,
                     postObject: parameters,
                     responseObject: WrapperModel<MainModel>.self) { [unowned self] data, error in
                      if let error = error {
                        self.presenter?.onFiltrationError(error)
                        return
                      }
                      
                      guard let model = data else { return }
                      self.presenter?.onIteractorGetFilteredItems(model)
    }
  }
}
