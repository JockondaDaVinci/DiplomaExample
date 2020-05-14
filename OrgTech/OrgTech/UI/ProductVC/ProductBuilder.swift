//
//  PProductBuilder.swift
//  OrgTech
//
//  Created by Maksym Balukhtin on 22.04.2020.
//  Copyright © 2020 Maksym Balukhtin. All rights reserved.
//

import Foundation

final class ProductBuilder: BaseBuilder {
  static func create() -> (presenter: ProductInputs, view: Modulable, router: BaseRouter) {
    let view = ProductViewController()
    let presenter = ProductPresenter()
    let interactor = ProductInteractor()
    let router = ProductRouter()

    view.presenter = presenter
    
    presenter.view = view
    presenter.interactor = interactor
    presenter.router = router
    
    interactor.presenter = presenter
    
    router.view = view

    return (presenter, view, router)
  }
}
