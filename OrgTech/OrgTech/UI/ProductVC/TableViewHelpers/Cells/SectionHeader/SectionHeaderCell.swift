//
//  SectionHeaderCell.swift
//  OrgTech
//
//  Created by Maksym Balukhtin on 28.04.2020.
//  Copyright © 2020 Maksym Balukhtin. All rights reserved.
//

import UIKit

typealias SectionType = (title: String, isAccessoryVisible: Bool)

enum SectionHeaderCellEvent {
  case onAccessoryAction
}

final class SectionHeaderCell: BuildableTableViewCell<SectionHeaderCellView, SectionType> {
  var eventHandler: EventHandler<SectionHeaderCellEvent>?
  
  override func config(with object: SectionType) {
    mainView.titleLabel.text = object.title
    mainView.accessoryButton.isHidden = !object.isAccessoryVisible
    
    setupActions()
  }
}

private extension SectionHeaderCell {
  func setupActions() {
    mainView.accessoryButton.addAction(for: .touchUpInside) { [unowned self] in
      self.eventHandler?(.onAccessoryAction)
    }
  }
}
