//
//  AddReviewViewController.swift
//  OrgTech
//
//  Created by Maksym Balukhtin on 29.04.2020.
//  Copyright © 2020 Maksym Balukhtin. All rights reserved.
//

import Foundation
import UIKit

enum AddReviewViewEvent {
  case onDoneButtonAction
  case onSubmitButtonAction
  case onChangeInput([UserInputType])
}


protocol AddReviewPresenterToView: NSObject, ValidationHandlable {
  func setupInitialState()
  func onDoneButtonAction()
}


final class AddReviewViewController: BuildableViewController<AddReviewView> {
  var presenter: AddReviewViewToPresenter?

  override func viewDidLoad() {
    super.viewDidLoad()
    presenter?.onViewLoaded()
  }
}


extension AddReviewViewController: AddReviewPresenterToView {
  func onDoneButtonAction() {
    closeKeyboard()
  }
  
  func setupInitialState() {
    setupUI()
    setupActions()
  }
}

extension AddReviewViewController: ValidationHandlable {
  func hideInputErrorMessage(inputType: UserInputType) {
    switch inputType {
    case .review(let reviewInput):
      switch reviewInput {
      case .userName:
        mainView.nameTextField.setValid()
      case .comment:
        mainView.reviewTextView.setValid()
      default:
        break
      }
    case .userName:
      mainView.nameTextField.setValid()
    default: break
    }
  }
  
  func showInputErrorMessage(inputType: UserInputType, message: String) {
    switch inputType {
    case .review(let reviewInput):
      switch reviewInput {
      case .comment:
        mainView.reviewTextView.showValidationErrorMessage(message)
      default:
        break
      }
    case .userName:
      mainView.nameTextField.showValidationErrorMessage(message)
    default: break
    }
  }
  
  func toggleButton(isEnabled: Bool) {
    mainView.submitButton.isEnabled = isEnabled
  }
}

private extension AddReviewViewController {
  func setupUI() {
    self.isKeyboardHandlable = true
    adjustConstraintForKeyboard(mainView._buttonBottom)
  }
  
  func setupActions() {
    mainView.submitButton.addAction(for: .touchUpInside) { [unowned self] in
      self.presenter?.onViewEvent(.onSubmitButtonAction)
    }
    
    mainView.doneButton.addAction(for: .touchUpInside) { [unowned self] in
      self.presenter?.onViewEvent(.onDoneButtonAction)
    }
    
    mainView.nameTextField.addAction(for: .editingChanged) { [unowned self] in
      self.presenter?.onViewEvent(.onChangeInput([.review(.userName(self.mainView.nameTextField.text)),
                                                  .review(.comment(self.mainView.reviewTextView.text)),
                                                  .review(.rating(self.mainView.ratingView.rating))]))
    }
    
    mainView.reviewTextView.textChanged = { [unowned self] text in
      self.presenter?.onViewEvent(.onChangeInput([.review(.comment(text)),
                                                  .review(.userName(self.mainView.nameTextField.text)),
                                                  .review(.rating(self.mainView.ratingView.rating))]))
    }
    
    mainView.ratingView.eventHandler = { [unowned self] rating in
      self.presenter?.onViewEvent(.onChangeInput([.review(.rating(rating)),
                                                  .review(.comment(self.mainView.reviewTextView.text)),
                                                  .review(.userName(self.mainView.nameTextField.text))]))
    }
  }
}
