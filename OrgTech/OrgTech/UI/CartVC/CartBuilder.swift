//
//  CartBuilder.swift
//  OrgTech
//
//  Created by Maksym Balukhtin on 22.04.2020.
//  Copyright © 2020 Maksym Balukhtin. All rights reserved.
//

import Foundation

final class CartBuilder: BaseBuilder {
  static func create() -> (presenter: CartInputs, view: Modulable, router: BaseRouter) {
    let view = CartViewController()
    let presenter = CartPresenter()
    let interactor = CartInteractor()
    let router = CartRouter()

    view.presenter = presenter
    
    presenter.view = view
    presenter.interactor = interactor
    presenter.router = router
    
    interactor.presenter = presenter
    
    router.view = view

    return (presenter, view, router)
  }
}
