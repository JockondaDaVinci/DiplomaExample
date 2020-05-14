//
//  AddReviewBuilder.swift
//  OrgTech
//
//  Created by Maksym Balukhtin on 29.04.2020.
//  Copyright © 2020 Maksym Balukhtin. All rights reserved.
//

import Foundation

final class AddReviewBuilder: BaseBuilder {
  static func create() -> (presenter: AddReviewInputs, view: Modulable, router: BaseRouter) {
    let view = AddReviewViewController()
    let presenter = AddReviewPresenter()
    let interactor = AddReviewInteractor()
    let router = AddReviewRouter()
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
