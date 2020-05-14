//
//  SearchBuilder.swift
//  OrgTech
//
//  Created by Maksym Balukhtin on 22.04.2020.
//  Copyright © 2020 Maksym Balukhtin. All rights reserved.
//

import Foundation

final class SearchBuilder: BaseBuilder {
  static func create() -> (presenter: SearchInputs, view: Modulable, router: BaseRouter) {
    let view = SearchViewController()
    let presenter = SearchPresenter()
    let interactor = SearchInteractor()
    let router = SearchRouter()

    view.presenter = presenter
    
    presenter.view = view
    presenter.interactor = interactor
    presenter.router = router
    
    interactor.presenter = presenter
    
    router.view = view

    return (presenter, view, router)
  }
}
