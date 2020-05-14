//
//  FilterViewController.swift
//  OrgTech
//
//  Created by Maksym Balukhtin on 30.04.2020.
//  Copyright © 2020 Maksym Balukhtin. All rights reserved.
//

import Foundation
import UIKit

enum FilterViewEvent {
  case onPickerEvent(PickerManagerEvent)
  case onColorPicked(String)
  case onPricePicked(min: Double, max: Double)
  case onConfirmButtonAction
  case onDoneButtonAction
}


protocol FilterPresenterToView: AnyObject {
  func setupInitialState()
  func setupUI(with parameters: FilterGetModel)
  func updateTextField(with text: String)
  func updatePrices(with prices: (min: Double, max: Double))
  func selectFromPicker()
}


final class FilterViewController: BuildableViewController<FilterView> {
  var presenter: FilterViewToPresenter?
  var pickerManager: PickerManager?

  override func viewDidLoad() {
    super.viewDidLoad()
    presenter?.onViewLoaded()
  }
}


extension FilterViewController: FilterPresenterToView {
  func selectFromPicker() {
    mainView.brandsTextField.text = pickerManager?.selectCurrent()
    closeKeyboard()
  }
  
  func setupUI(with parameters: FilterGetModel) {
    if parameters.minPrice.doubleValue != parameters.maxPrice.doubleValue {
      mainView.pricePickerView.maximumValue = parameters.maxPrice.doubleValue
      mainView.pricePickerView.minimumValue = parameters.minPrice.doubleValue
      mainView.minPriceLabel.text = parameters.minPrice
      mainView.maxPriceLabel.text = parameters.maxPrice
    } else {
      mainView.priceStackView.isHidden = true
    }
    
    if parameters.color.isEmpty {
      mainView.colorStackView.isHidden = true
    } else {
      mainView.colorPickerView.fill(with: parameters.color)
    }
    
    if parameters.brandName.isEmpty {
      mainView.brandsStackView.isHidden = true
    } else {
      pickerManager = PickerManager(mainView.pickerView, data: parameters.brandName)
      pickerManager?.eventHandler = { [unowned self] event in
        self.presenter?.onViewEvent(.onPickerEvent(event))
      }
    }
  }
  
  func updateTextField(with text: String) {
    mainView.brandsTextField.text = text
  }
  
  func updatePrices(with prices: (min: Double, max: Double)) {
    mainView.minPriceLabel.text = "\(Int(prices.min))"
    mainView.maxPriceLabel.text = "\(Int(prices.max))"
  }
  
  func setupInitialState() {
    setupUI()
    setupActions()
  }
}


private extension FilterViewController {
  func setupUI() {
    title = "Filter"
    isKeyboardHandlable = true
    adjustConstraintForKeyboard(mainView._buttonBottom)
  }
  
  func setupActions() {
    mainView.pricePickerView.eventHandler = { [unowned self] value in
      self.presenter?.onViewEvent(.onPricePicked(min: value.min, max: value.max))
    }
    
    mainView.colorPickerView.eventHandler = { [unowned self] color in
      self.presenter?.onViewEvent(.onColorPicked(color))
    }
    
    mainView.confirmButton.addAction(for: .touchUpInside) { [unowned self] in
      self.presenter?.onViewEvent(.onConfirmButtonAction)
    }
    
    mainView.doneButton.addAction(for: .touchUpInside) { [unowned self] in
      self.presenter?.onViewEvent(.onDoneButtonAction)
    }
  }
}
