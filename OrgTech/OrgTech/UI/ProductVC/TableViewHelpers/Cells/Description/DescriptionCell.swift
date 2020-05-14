//
//  DescriptionCell.swift
//  OrgTech
//
//  Created by Maksym Balukhtin on 28.04.2020.
//  Copyright © 2020 Maksym Balukhtin. All rights reserved.
//

import Foundation

final class DescriptionCell: BuildableTableViewCell<DescriptionCellView, String> {
  override func config(with object: String) {
    mainView.descLabel.text = object
  }
}
