//
//  HomePageBuilder.swift
//  OrgTech
//
//  Created by Maksym Balukhtin on 22.04.2020.
//  Copyright © 2020 Maksym Balukhtin. All rights reserved.
//

import Foundation

final class HomePageBuilder: BaseBuilder {
  static func create() -> (presenter: HomePageInputs, view: Modulable, router: BaseRouter) {
    let view = HomePageViewController()
    let presenter = HomePagePresenter()
    let interactor = HomePageInteractor()
    let router = HomePageRouter()

    view.presenter = presenter
    
    presenter.view = view
    presenter.router = router
    presenter.interactor = interactor
    
    interactor.presenter = presenter
    
    router.view = view

    return (presenter, view, router)
  }
}
