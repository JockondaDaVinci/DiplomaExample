//
//  AddReviewPresenter.swift
//  OrgTech
//
//  Created by Maksym Balukhtin on 29.04.2020.
//  Copyright © 2020 Maksym Balukhtin. All rights reserved.
//

import Foundation

protocol AddReviewViewToPresenter {
  func onViewLoaded()
  func onViewEvent(_ event: AddReviewViewEvent)
}

protocol AddReviewInteractorToPresenter: UserInputProcessable {
  
}

protocol AddReviewInputs: Inputs {
  
}


final class AddReviewPresenter: AddReviewInputs {
  weak var view: AddReviewPresenterToView?
  var interactor: AddReviewPresenterToInteractor?
  var router: AddReviewRouter.Routes?
  
  //Module input
}


extension AddReviewPresenter: AddReviewViewToPresenter {
  func onViewLoaded() {
    view?.setupInitialState()
  }
  
  func onViewEvent(_ event: AddReviewViewEvent) {
    switch event {
    case .onSubmitButtonAction:
      router?.close()
    case .onChangeInput(let input):
      interactor?.validateUserInput(inputTypes: input)
    case .onDoneButtonAction:
      view?.onDoneButtonAction()
    }
  }
}


extension AddReviewPresenter: AddReviewInteractorToPresenter {
  func onInteractorError(_ error: Error) {
    
  }
}

extension AddReviewPresenter: UserInputProcessable {
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
      case .invalidInput(let input):
        view?.showInputErrorMessage(inputType: input, message: error.localizedDescription)
      case .emptyInput(let input):
        view?.hideInputErrorMessage(inputType: input)
      }
      view?.toggleButton(isEnabled: false)
    default: break
    }
  }
}
