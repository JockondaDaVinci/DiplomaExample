//
//  FilterModuleFactory.swift
//  OrgTech
//
//  Created by Maksym Balukhtin on 30.04.2020.
//  Copyright © 2020 Maksym Balukhtin. All rights reserved.
//

import Foundation

final class FilterBuilder: BaseBuilder {
  static func create() -> (presenter: FilterInputs, view: Modulable, router: BaseRouter) {
    let view = FilterViewController()
    let presenter = FilterPresenter()
    let interactor = FilterInteractor()
    let router = FilterRouter()

    view.presenter = presenter
    
    presenter.view = view
    presenter.interactor = interactor
    presenter.router = router
    
    interactor.presenter = presenter
    
    router.view = view

    return (presenter, view, router)
  }
}
