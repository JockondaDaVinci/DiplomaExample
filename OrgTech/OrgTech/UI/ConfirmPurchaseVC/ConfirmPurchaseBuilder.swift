//
//  ConfirmPurchaseBuilder.swift
//  OrgTech
//
//  Created by Maksym Balukhtin on 29.04.2020.
//  Copyright © 2020 Maksym Balukhtin. All rights reserved.
//

import Foundation

final class ConfirmPurchaseBuilder: BaseBuilder {
  static func create() -> (presenter: ConfirmPurchaseInputs, view: Modulable, router: BaseRouter) {
    let view = ConfirmPurchaseViewController()
    let presenter = ConfirmPurchasePresenter()
    let interactor = ConfirmPurchaseInteractor()
    let router = ConfirmPurchaseRouter()
    let validationService = UserInputValidationService()

    view.presenter = presenter
    
    presenter.view = view
    presenter.interactor = interactor
    presenter.router = router
    
    interactor.presenter = presenter
    interactor.validationService = validationService
    
    router.view = view

    return (presenter, view, router)
  }
}
