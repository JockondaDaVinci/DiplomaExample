//
//  SearchInteractor.swift
//  OrgTech
//
//  Created by Maksym Balukhtin on 22.04.2020.
//  Copyright © 2020 Maksym Balukhtin. All rights reserved.
//

import Foundation

protocol SearchPresenterToInteractor {
  func performSearch(by query: String?)
}


final class SearchInteractor {
  var presenter: SearchInteractorToPresenter?
}


extension SearchInteractor: SearchPresenterToInteractor {
  func performSearch(by query: String?) {
    guard let query = query else {
      presenter?.onInteractorError(NetworkError.invalidURL)
      return
    }
    NetworkingManager.shared
      .startGetTask(forURL: Product.search(byQuery: query), object: WrapperModel<ShortProductModel>.self) { [unowned self] data, error in
      if let error = error {
        self.presenter?.onInteractorError(error)
        return
      }
      
      guard let model = data else { return }
      self.presenter?.onInteractorSuccess(model)
    }
  }
}
