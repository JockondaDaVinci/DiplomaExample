//
//  ConfirmPurchaseViewController.swift
//  OrgTech
//
//  Created by Maksym Balukhtin on 29.04.2020.
//  Copyright © 2020 Maksym Balukhtin. All rights reserved.
//

import Foundation
import UIKit

enum ConfirmPurchaseViewEvent {
  case onPickerEvent(PickerManagerEvent)
  case onInputChanged([UserInputType])
  case onConfirmButtonAction
  case onDoneButtonAction
}


protocol ConfirmPurchasePresenterToView: NSObject, ValidationHandlable {
  func setupInitialState()
  func updateTextField(with text: String)
  func selectFromPicker()
}


final class ConfirmPurchaseViewController: BuildableViewController<ConfirmPurchaseView> {
  var presenter: ConfirmPurchaseViewToPresenter?
  var pickerManager: PickerManager?

  override func viewDidLoad() {
    super.viewDidLoad()
    presenter?.onViewLoaded()
  }
}


extension ConfirmPurchaseViewController: ConfirmPurchasePresenterToView {
  func selectFromPicker() {
    mainView.deliveryTypeTextField.text = pickerManager?.selectCurrent()
    closeKeyboard()
  }
  
  func updateTextField(with text: String) {
    mainView.deliveryTypeTextField.text = text
  }
  
  func setupInitialState() {
    setupUI()
    setupActions()
  }
}

extension ConfirmPurchaseViewController: ValidationHandlable {
  func showInputErrorMessage(inputType: UserInputType, message: String) {
    switch inputType {
    case .confirmPurchase(let confirmType):
      switch confirmType {
      case .address:
        mainView.addressTextField.showValidationErrorMessage(message)
      case .deliveryType:
        mainView.deliveryTypeTextField.showValidationErrorMessage(message)
      default: break
      }
    case .email:
      mainView.emailTextField.showValidationErrorMessage(message)
    case .userName:
      mainView.nameTextField.showValidationErrorMessage(message)
    default: break
    }
  }
  
  func hideInputErrorMessage(inputType: UserInputType) {
    switch inputType {
    case .confirmPurchase(let confirmType):
      switch confirmType {
      case .email:
        mainView.emailTextField.setValid()
      case .userName:
        mainView.nameTextField.setValid()
      case .address:
        mainView.addressTextField.setValid()
      case .deliveryType:
        mainView.deliveryTypeTextField.setValid()
      }
    case .email:
      mainView.emailTextField.setValid()
    case .userName:
      mainView.nameTextField.setValid()
    default: break
    }
  }
  
  func toggleButton(isEnabled: Bool) {
    mainView.confirmButton.isEnabled = isEnabled
  }
}

private extension ConfirmPurchaseViewController {
  func setupUI() {
    isKeyboardHandlable = true
    adjustConstraintForKeyboard(mainView._buttonBottom)
    pickerManager = PickerManager(mainView.pickerView, data: ["Нова Пошта", "УкрПошта", "Самовывоз"])
    mainView.titleLabel.text = [AppDefaults.Strings.Placeholder.totalPrice, "₴",  "\(CartManager.shared.totalPrice() ?? -1)"].joined(separator: " ")
  }
  
  func setupActions() {
    mainView.confirmButton.addAction(for: .touchUpInside) { [unowned self] in
      self.presenter?.onViewEvent(.onConfirmButtonAction)
    }
    
    mainView.doneButton.addAction(for: .touchUpInside) { [unowned self] in
      self.presenter?.onViewEvent(.onDoneButtonAction)
    }
    
    mainView.emailTextField.addAction(for: .editingChanged) {
      self.presenter?.onViewEvent(.onInputChanged([.confirmPurchase(.email(self.mainView.emailTextField.text)),
                                                   .confirmPurchase(.userName(self.mainView.nameTextField.text)),
                                                   .confirmPurchase(.address(self.mainView.addressTextField.text)),
                                                   .confirmPurchase(.deliveryType(self.mainView.deliveryTypeTextField.text))]))
    }
    
    mainView.nameTextField.addAction(for: .editingChanged) {
      self.presenter?.onViewEvent(.onInputChanged([.confirmPurchase(.userName(self.mainView.nameTextField.text)),
                                                   .confirmPurchase(.email(self.mainView.emailTextField.text)),
                                                   .confirmPurchase(.address(self.mainView.addressTextField.text)),
                                                   .confirmPurchase(.deliveryType(self.mainView.deliveryTypeTextField.text))]))
    }
    
    mainView.addressTextField.addAction(for: .editingChanged) {
      self.presenter?.onViewEvent(.onInputChanged([.confirmPurchase(.address(self.mainView.addressTextField.text)),
                                                   .confirmPurchase(.email(self.mainView.emailTextField.text)),
                                                   .confirmPurchase(.userName(self.mainView.nameTextField.text)),
                                                   .confirmPurchase(.deliveryType(self.mainView.deliveryTypeTextField.text))]))
    }
    
    mainView.deliveryTypeTextField.addAction(for: .editingDidEnd) {
      self.presenter?.onViewEvent(.onInputChanged([.confirmPurchase(.deliveryType(self.mainView.deliveryTypeTextField.text)),
                                                   .confirmPurchase(.email(self.mainView.emailTextField.text)),
                                                   .confirmPurchase(.userName(self.mainView.nameTextField.text)),
                                                   .confirmPurchase(.address(self.mainView.addressTextField.text))]))
    }
    
    pickerManager?.eventHandler = { [unowned self] event in
      self.presenter?.onViewEvent(.onPickerEvent(event))
    }
  }
}
