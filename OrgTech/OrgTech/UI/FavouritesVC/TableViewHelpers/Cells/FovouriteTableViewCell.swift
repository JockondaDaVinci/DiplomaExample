//
//  FovouriteTableViewCell.swift
//  OrgTech
//
//  Created by Maksym Balukhtin on 01.05.2020.
//  Copyright © 2020 Maksym Balukhtin. All rights reserved.
//

import UIKit

final class FovouriteTableViewCell: BuildableTableViewCell<FovouriteTableViewCellView, ShortProductModel> {
  override func config(with object: ShortProductModel) {
    mainView.imageView.downloaded(fromURL: object.image)
    mainView.nameLabel.text = object.name
  }
}
