//
//  FavouritesBuilder.swift
//  OrgTech
//
//  Created by Maksym Balukhtin on 01.05.2020.
//  Copyright © 2020 Maksym Balukhtin. All rights reserved.
//

import Foundation

final class FavouritesBuilder: BaseBuilder {
  static func create() -> (presenter: FavouritesInputs, view: Modulable, router: BaseRouter) {
    let view = FavouritesViewController()
    let presenter = FavouritesPresenter()
    let interactor = FavouritesInteractor()
    let router = FavouritesRouter()

    view.presenter = presenter
    
    presenter.view = view
    presenter.interactor = interactor
    presenter.router = router
    
    interactor.presenter = presenter
    
    router.view = view

    return (presenter, view, router)
  }
}
