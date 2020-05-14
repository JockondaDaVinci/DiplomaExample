//
//  HomeBuilder.swift
//  OrgTech
//
//  Created by Maksym Balukhtin on 22.04.2020.
//  Copyright © 2020 Maksym Balukhtin. All rights reserved.
//

import Foundation

final class HomeBuilder: BaseBuilder {
  static func create() -> (presenter: HomeInputs, view: Modulable, router: BaseRouter) {
    let view = HomeViewController()
    let presenter = HomePresenter()
    let interactor = HomeInteractor()
    let router = HomeRouter()
    
    view.presenter = presenter
    
    presenter.view = view
    presenter.interactor = interactor
    presenter.router = router
    
    router.view = view
    
    interactor.presenter = presenter
    return(presenter, view, router)
  }
}
