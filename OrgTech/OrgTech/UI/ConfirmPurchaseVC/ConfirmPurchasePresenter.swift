//
//  ConfirmPurchasePresenter.swift
//  OrgTech
//
//  Created by Maksym Balukhtin on 29.04.2020.
//  Copyright © 2020 Maksym Balukhtin. All rights reserved.
//

import Foundation

protocol ConfirmPurchaseViewToPresenter {
  func onViewLoaded()
  func onViewEvent(_ event: ConfirmPurchaseViewEvent)
}

protocol ConfirmPurchaseInteractorToPresenter: UserInputProcessable {
  
}

protocol ConfirmPurchaseInputs: Inputs {
  
}


final class ConfirmPurchasePresenter: ConfirmPurchaseInputs {
  weak var view: ConfirmPurchasePresenterToView?
  var interactor: ConfirmPurchasePresenterToInteractor?
  var router: ConfirmPurchaseRouter.Routes?
  
  //Module input
}


extension ConfirmPurchasePresenter: ConfirmPurchaseViewToPresenter {
  func onViewLoaded() {
    view?.setupInitialState()
  }
  
  func onViewEvent(_ event: ConfirmPurchaseViewEvent) {
    switch event {
    case .onPickerEvent(let event):
      switch event {
      case .onPickerAction(let text):
        view?.updateTextField(with: text)
      }
    case .onInputChanged(let inputs):
      interactor?.validateUserInput(inputTypes: inputs)
    case .onConfirmButtonAction:
      CartManager.shared.empty()
      router?.close()
    case .onDoneButtonAction:
      view?.selectFromPicker()
    }
  }
}


extension ConfirmPurchasePresenter: ConfirmPurchaseInteractorToPresenter {
  func onInteractorError(_ error: Error) {
    
  }
}

extension ConfirmPurchasePresenter: UserInputProcessable {
  func onInteractorInputIsValid(inputType: UserInputType) {
    view?.hideInputErrorMessage(inputType: inputType)
  }
  
  func onInteractorAllInputsAreValid() {
    view?.toggleButton(isEnabled: true)
  }
  
  func onInteractorInputIsInvalid(_ error: Error) {
    switch error {
    case let error as ValidationServiceError:
      switch error {
      case .invalidInput(let inputs):
        view?.showInputErrorMessage(inputType: inputs, message: error.localizedDescription)
      case .emptyInput(let inputs):
        view?.hideInputErrorMessage(inputType: inputs)
      }
      view?.toggleButton(isEnabled: false)
    default: break
    }
  }
}
