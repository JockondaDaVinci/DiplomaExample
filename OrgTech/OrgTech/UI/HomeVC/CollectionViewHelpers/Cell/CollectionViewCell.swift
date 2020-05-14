//
//  CollectionViewCell.swift
//  OrgTech
//
//  Created by Maksym Balukhtin on 22.04.2020.
//  Copyright © 2020 Maksym Balukhtin. All rights reserved.
//

import UIKit

class CollectionViewCell: BuildableCollectionViewCell<CollectionViewCellView, MainModelProtocol> {
  override func config(with object: MainModelProtocol) {
    mainView.imageView.downloaded(fromURL: object.image)
    mainView.titleLabel.text = object.name
    mainView.priceLabel.text = "\(object.price?.value ?? -1)"
    if let sale = object.sale?.value {
      mainView.specialOfferView.type = .sale(sale)
    }
  }
}
