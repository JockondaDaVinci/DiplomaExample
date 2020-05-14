//
//  UserInputValidatable.swift
//  OrgTech
//
//  Created by Maksym Balukhtin on 02.05.2020.
//  Copyright © 2020 Maksym Balukhtin. All rights reserved.
//

import Foundation

protocol UserInputValidatable: AnyObject {
  var inputProcesser: UserInputProcessable? {get}
  var validationService: UserInputValidationServiceProtocol! {get}
  
  func validateUserInput(inputTypes: [UserInputType])
}

extension UserInputValidatable {
  func validateUserInput(inputTypes: [UserInputType]) {
    do {
      for inputType in inputTypes {
        try validateInput(inputType)
        inputProcesser?.onInteractorInputIsValid(inputType: inputType)
      }
      inputProcesser?.onInteractorAllInputsAreValid()
    } catch {
      inputProcesser?.onInteractorInputIsInvalid(error)
    }
  }
  
  private func validateInput(_ inputType: UserInputType) throws {
    do {
      switch inputType {
      case .email(let email):
        try validationService.validateEmail(email)
      case .userName(let userName):
        try validationService.validateUserName(userName)
      case .review(let userReview):
        try validationService.validateReviewInputs(userReview)
      case .confirmPurchase(let confirmPurchare):
        try validationService.validateConfirmPurchaseInputs(confirmPurchare)
      }
    } catch {
      throw error
    }
  }
}

