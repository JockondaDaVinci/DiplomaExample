//
//  PickerManager.swift
//  OrgTech
//
//  Created by Maksym Balukhtin on 30.04.2020.
//  Copyright © 2020 Maksym Balukhtin. All rights reserved.
//

import UIKit

enum PickerManagerEvent {
  case onPickerAction(String)
}

class PickerManager: NSObject {
  private var data: [String]
  private var pickerView: UIPickerView
  
  var eventHandler: EventHandler<PickerManagerEvent>?
  
  init(_ pickerView: UIPickerView, data: [String]) {
    self.pickerView = pickerView
    self.data = data
    super.init()
    
    pickerView.delegate = self
    pickerView.dataSource = self
    pickerView.reloadAllComponents()
  }
  
  func selectCurrent() -> String {
    let row = pickerView.selectedRow(inComponent: 0)
    pickerView.selectRow(row, inComponent: 0, animated: false)
    return data[row]
  }
}

extension PickerManager: UIPickerViewDataSource {
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }
  
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return data.count
  }
  
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    return data[row]
  }
}

extension PickerManager: UIPickerViewDelegate {
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    let item = data[row]
    eventHandler?(.onPickerAction(item))
  }
}
