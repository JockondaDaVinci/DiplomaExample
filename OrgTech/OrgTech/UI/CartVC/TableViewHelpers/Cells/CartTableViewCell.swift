//
//  CartTableViewCell.swift
//  OrgTech
//
//  Created by Maksym Balukhtin on 29.04.2020.
//  Copyright © 2020 Maksym Balukhtin. All rights reserved.
//

import UIKit

final class CartTableViewCell: BuildableTableViewCell<CartTableViewCellView, ShortProductModel> {
  override func config(with object: ShortProductModel) {
    mainView.imageView.downloaded(fromURL: object.image)
    mainView.nameLabel.text = object.name
    mainView.colorPicker.fill(with: [object.color ?? ""])
    mainView.colorPicker.preSelected = false
    mainView.qtyPriceLabel.text = [object.quantity ?? "", "x ₴", "\(object.price?.value ?? -1)"].joined(separator: " ")
    
    mainView.finalPriceLabel.text = ["₴", "\((object.price?.value ?? -1) * (object.quantity?.intValue ?? 0))"].joined(separator: " ")
    
    selectionStyle = .none
  }
}
