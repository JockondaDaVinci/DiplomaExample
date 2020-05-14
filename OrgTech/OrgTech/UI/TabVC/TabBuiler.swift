//
//  TabBuiler.swift
//  OrgTech
//
//  Created by Maksym Balukhtin on 22.04.2020.
//  Copyright © 2020 Maksym Balukhtin. All rights reserved.
//

import UIKit

final class TabBuilder: BaseBuilder {
  static func create() -> (presenter: PresenterInputs, view: Modulable, router: BaseRouter) {
    let view = TabViewController()
    let presenter = TabPresenter()
    let router = TabRouter()
    
    view.presenter = presenter
    
    presenter.view = view
    presenter.router = router
    return (presenter, view, router)
  }
}
