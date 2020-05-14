//
//  FilterPresenter.swift
//  OrgTech
//
//  Created by Maksym Balukhtin on 30.04.2020.
//  Copyright © 2020 Maksym Balukhtin. All rights reserved.
//

import Foundation

protocol FilterViewToPresenter {
  func onViewLoaded()
  func onViewEvent(_ event: FilterViewEvent)
}

protocol FilterInteractorToPresenter {
  func onInteractorError(_ error: Error)
  func onInteractorGetFilterParameters(_ parameters: FilterGetModel)
  func onIteractorGetFilteredItems(_ data: [MainModelProtocol])
  func onFiltrationError(_ error: Error)
}

protocol FilterInputsDelegate {
  func filterDidReceiveFilteredItems(_ data: [MainModelProtocol])
  func filterDidReceiveError()
}

protocol FilterInputs: Inputs {
  var categoryID: String? { get set }
  var delegate: FilterInputsDelegate? { get set }
}


final class FilterPresenter: FilterInputs {
  weak var view: FilterPresenterToView?
  var interactor: FilterPresenterToInteractor?
  var router: FilterRouter.Routes?
  var delegate: FilterInputsDelegate?
  
  //Module input
  var categoryID: String?
  var filterParameters: FilterPostModel?
}


extension FilterPresenter: FilterViewToPresenter {
  func onViewLoaded() {
    view?.setupInitialState()
    guard let categoryID = categoryID else { return }
    interactor?.getFilterParameters(forID: categoryID)
    filterParameters = FilterPostModel.newEmpty(categoryID.intValue)
  }
  
  func onViewEvent(_ event: FilterViewEvent) {
    switch event {
    case .onPickerEvent(let pickerEvent):
      switch pickerEvent {
      case .onPickerAction(let brand):
        filterParameters?.brandName = brand
        view?.updateTextField(with: brand)
      }
    case .onColorPicked(let color):
      filterParameters?.color = color
    case .onPricePicked(let min, let max):
      filterParameters?.min = Int(min)
      filterParameters?.max = Int(max)
      view?.updatePrices(with: (min, max))
    case .onConfirmButtonAction:
      guard let filterParameters = filterParameters else { return }
      interactor?.performFilter(byParametes: filterParameters)
    case .onDoneButtonAction:
      view?.selectFromPicker()
    }
  }
}


extension FilterPresenter: FilterInteractorToPresenter {
  func onInteractorGetFilterParameters(_ parameters: FilterGetModel) {
    view?.setupUI(with: parameters)
  }
  
  func onIteractorGetFilteredItems(_ data: [MainModelProtocol]) {
    delegate?.filterDidReceiveFilteredItems(data)
    router?.close()
  }
  
  func onInteractorError(_ error: Error) {
    debugPrint(error)
  }
  
  func onFiltrationError(_ error: Error) {
    delegate?.filterDidReceiveError()
    router?.close()
  }
}
