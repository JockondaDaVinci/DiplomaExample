//
//  ViewBuildable.swift
//  FannexSDK
//
//  Created by Maksym Balukhtin on 7/16/19.
//  Copyright © 2019 Maksym Balukhtin. All rights reserved.
//

import UIKit

class BuildableView: UIView {
  let doneButton = UIButton()
  lazy var toolBar: UIToolbar = {
    let toolBar = UIToolbar()
    let flex = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    let done = UIBarButtonItem(customView: doneButton)
    toolBar.items = [flex, done]
    toolBar.sizeToFit()
    return toolBar
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    addViews()
    configureViews()
    anchorViews()
  }
  
  @available(*, unavailable) required init?(coder aDecoder: NSCoder) {
    fatalError("not implemented")
  }
  
  func addViews() { }
  
  func configureViews() {
    backgroundColor = AppDefaults.Colors.white
  }
  
  func anchorViews() { }
}
