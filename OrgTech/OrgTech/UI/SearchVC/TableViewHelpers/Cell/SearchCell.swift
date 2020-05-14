//
//  SearchCell.swift
//  OrgTech
//
//  Created by Maksym Balukhtin on 29.04.2020.
//  Copyright © 2020 Maksym Balukhtin. All rights reserved.
//

import UIKit

final class SearchCell: BuildableTableViewCell<SearchCellView, ShortProductModel> {
  override func config(with object: ShortProductModel) {
    mainView.imageView.downloaded(fromURL: object.image)
    mainView.nameLabel.text = object.name
    mainView.priceLabel.text = ["₴", "\(object.price?.value ?? -1)"].joined(separator: " ")
  }
}
