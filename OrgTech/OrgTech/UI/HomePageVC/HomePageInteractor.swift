//
//  HomePageInteractor.swift
//  OrgTech
//
//  Created by Maksym Balukhtin on 22.04.2020.
//  Copyright © 2020 Maksym Balukhtin. All rights reserved.
//

import Foundation

protocol HomePagePresenterToInteractor {
  func getMain()
}


final class HomePageInteractor {
  var presenter: HomePageInteractorToPresenter?
}


extension HomePageInteractor: HomePagePresenterToInteractor {
  func getMain() {
    NetworkingManager.shared.startGetTask(forURL: Product.main, object: WrapperModel<MainModel>.self) { [unowned self] data, error in
      if let error = error {
        self.presenter?.onInteractorError(error)
        return
      }
      
      guard let model = data else { return }
      self.presenter?.onInteractorSuccess(model)
    }
  }
}
