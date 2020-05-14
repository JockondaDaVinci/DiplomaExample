//
//  TableViewCell.swift
//  OrgTech
//
//  Created by Maksym Balukhtin on 22.04.2020.
//  Copyright © 2020 Maksym Balukhtin. All rights reserved.
//

import UIKit

final class MenuTableViewCell: BuildableTableViewCell<TableViewCellView, CategoryModel> {
  override func config(with object: CategoryModel) {
    mainView.titleLabel.text = object.name
    mainView.countView.isHidden = object.isStatic == nil
    
    accessoryType = object.isStatic == nil ? .disclosureIndicator : .none
    selectionStyle = .none
  }
}
