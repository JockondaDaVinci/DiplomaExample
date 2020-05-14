//
//  MenuBuilder.swift
//  OrgTech
//
//  Created by Maksym Balukhtin on 22.04.2020.
//  Copyright © 2020 Maksym Balukhtin. All rights reserved.
//

import Foundation

final class MenuBuilder: BaseBuilder {
  static func create() -> (presenter: MenuInputs, view: Modulable, router: BaseRouter) {
    let view = MenuViewController()
    let presenter = MenuPresenter()
    let interactor = MenuInteractor()
    let router = MenuRouter()
    
    view.presenter = presenter
    
    presenter.view = view
    presenter.interactor = interactor
    presenter.router = router
    
    router.view = view
    
    interactor.presenter = presenter
    return(presenter, view, router)
  }
}
