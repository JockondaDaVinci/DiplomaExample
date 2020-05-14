//
//  ProductInteractor.swift
//  OrgTech
//
//  Created by Maksym Balukhtin on 22.04.2020.
//  Copyright © 2020 Maksym Balukhtin. All rights reserved.
//

import Foundation

protocol ProductPresenterToInteractor {
  func getProduct(byID id: String)
}


final class ProductInteractor {
  var presenter: ProductInteractorToPresenter?
}


extension ProductInteractor: ProductPresenterToInteractor {
  func getProduct(byID id: String) {
    let networkManager = NetworkingManager.shared
    networkManager.startGetTask(forURL: Product.getProduct(byID: id), object: ProductModel.self) { [unowned self] data, error in
      if let error = error {
        self.presenter?.onInteractorError(error)
        return
      }
      
      guard let model = data else { return }
      self.presenter?.onInteractorSuccess(model)
    }
  }
}
