//
//  ConfirmPurchaseInteractor.swift
//  OrgTech
//
//  Created by Maksym Balukhtin on 29.04.2020.
//  Copyright © 2020 Maksym Balukhtin. All rights reserved.
//

import Foundation

protocol ConfirmPurchasePresenterToInteractor: UserInputValidatable {
  
}


final class ConfirmPurchaseInteractor {
  var presenter: ConfirmPurchaseInteractorToPresenter?
  var validationService: UserInputValidationServiceProtocol!
}


extension ConfirmPurchaseInteractor: ConfirmPurchasePresenterToInteractor {
  var inputProcesser: UserInputProcessable? { return presenter }
}
