//
//  CategoryModuleFactory.swift
//  OrgTech
//
//  Created by Maksym Balukhtin on 29.04.2020.
//  Copyright © 2020 Maksym Balukhtin. All rights reserved.
//

import Foundation

final class CategoryBuilder: BaseBuilder {
  static func create() -> (presenter: CategoryInputs, view: Modulable, router: BaseRouter) {
    let view = CategoryViewController()
    let presenter = CategoryPresenter()
    let interactor = CategoryInteractor()
    let router = CategoryRouter()

    view.presenter = presenter
    
    presenter.view = view
    presenter.interactor = interactor
    presenter.router = router
    
    interactor.presenter = presenter
    
    router.view = view

    return (presenter, view, router)
  }
}
