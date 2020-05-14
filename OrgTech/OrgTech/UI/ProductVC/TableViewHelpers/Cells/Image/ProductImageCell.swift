//
//  ProductImageCell.swift
//  OrgTech
//
//  Created by Maksym Balukhtin on 23.04.2020.
//  Copyright © 2020 Maksym Balukhtin. All rights reserved.
//

import UIKit

final class ProductImageCell: BuildableTableViewCell<ProductImageCellView, String> {
  override func config(with object: String) {
    mainView.imageView.downloaded(fromURL: object)
  }
}
