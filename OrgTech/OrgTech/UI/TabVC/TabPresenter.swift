//
//  TabPresenter.swift
//  OrgTech
//
//  Created by Maksym Balukhtin on 22.04.2020.
//  Copyright © 2020 Maksym Balukhtin. All rights reserved.
//

import Foundation

protocol TabViewToPresenter {
  func onViewAppeared()
}

protocol PresenterInputs: Inputs { }

final class TabPresenter: PresenterInputs {
  weak var view: TabPresenterToView?
  var router: TabRouter?
}

extension TabPresenter: TabViewToPresenter {
  func onViewAppeared() {
    view?.setupInitialState()
  }
}
