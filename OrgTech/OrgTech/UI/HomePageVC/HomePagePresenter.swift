//
//  HomePagePresenter.swift
//  OrgTech
//
//  Created by Maksym Balukhtin on 22.04.2020.
//  Copyright © 2020 Maksym Balukhtin. All rights reserved.
//

import Foundation

protocol HomePageViewToPresenter {
  func onViewLoaded()
  func onViewEvent(_ event: HomePageViewEvent)
}

protocol HomePageInteractorToPresenter {
  func onInteractorError(_ error: Error)
  func onInteractorSuccess(_ data: [MainModelProtocol])
}

protocol HomePageInputs: Inputs { }


final class HomePagePresenter: HomePageInputs {
  weak var view: HomePagePresenterToView?
  var interactor: HomePagePresenterToInteractor?
  var router: HomePageRouter.Routes?
  //Module input
}


extension HomePagePresenter: HomePageViewToPresenter {
  func onViewLoaded() {
    view?.setupInitialState()
    interactor?.getMain()
  }
  
  func onViewEvent(_ event: HomePageViewEvent) {
    switch event {
    case .onPageControlEvent(let pageControlEvent):
      switch pageControlEvent {
      case .onPageChanged(let selectedIndex):
        view?.adjustControls(with: selectedIndex, segment: true)
      }
    case .onSegmentEvent(let selectedIndex):
      view?.adjustControls(with: selectedIndex, segment: false)
      break
    }
  }
}


extension HomePagePresenter: HomePageInteractorToPresenter {
  func onInteractorError(_ error: Error) {
    debugPrint(error)
  }
  
  func onInteractorSuccess(_ data: [MainModelProtocol]) {
    view?.populateData(data)
  }
}
