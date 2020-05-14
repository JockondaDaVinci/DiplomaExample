//
//  HomePresenter.swift
//  OrgTech
//
//  Created by Maksym Balukhtin on 22.04.2020.
//  Copyright © 2020 Maksym Balukhtin. All rights reserved.
//

import Foundation

protocol HomeViewToPrester {
  func onViewLoaded()
  func onViewEvent(_ event: HomeViewEvents)
}

protocol HomeIteractorToPresenter {
  func onTaskFailed(_ error: Error)
  func onTaskCompleted(_ object: WrapperModel<MainModel>)
}

protocol HomeInputs: Inputs {
  var insertedData: [MainModelProtocol]? { get set }
}

final class HomePresenter: HomeInputs {
  weak var view: HomePresenterToView?
  var interactor: HomePresenterToInteractor?
  var router: HomeRouter?
  
  var insertedData: [MainModelProtocol]? {
    didSet {
      guard let data = insertedData else { return }
      view?.populateData(data)
    }
  }
}

extension HomePresenter: HomeViewToPrester {
  func onViewLoaded() {
    view?.setupInitialState()
  }
  
  func onViewEvent(_ event: HomeViewEvents) {
    switch event {
    case .onCollectionViewEvent(let collectionEvent):
      switch collectionEvent {
      case .onCellAction(let id):
        router?.toProduct(withID: id)
      }
    }
  }
}

extension HomePresenter: HomeIteractorToPresenter {
  func onTaskFailed(_ error: Error) {
    debugPrint(error)
  }
  
  func onTaskCompleted(_ object: WrapperModel<MainModel>) {
    
  }
}
