//
//  ProductMainInfoCell.swift
//  OrgTech
//
//  Created by Maksym Balukhtin on 23.04.2020.
//  Copyright © 2020 Maksym Balukhtin. All rights reserved.
//

import Foundation

enum ProductMainInfoCellEvent {
  case onBuyButtonAction(ShortProductModel)
  case onFavButtonAction(ShortProductModel)
}

final class ProductMainInfoCell: BuildableTableViewCell<ProductMainInfoCellView, ProductModel> {
  var eventHandler: EventHandler<ProductMainInfoCellEvent>?
  private var product: ProductModel?
  
  override func config(with object: ProductModel) {
    self.product = object
    mainView.titleLabel.text = object.name
    mainView.ratingView.rating = object.rating.value ?? -1
    mainView.priceLabel.text = ["₴", "\(object.price?.value ?? -1)"].joined(separator: " ")
    mainView.qtyView.maximumValue = object.quantity.doubleValue
    mainView.colorPickerView.fill(with: object.color)
    mainView.colorPickerView.preSelected = true
    
    setupActions()
  }
  
  func setupButtonsTitles(isInCart: Bool, isFollowed: Bool) {
    let cartTitle = isInCart ?
      AppDefaults.Strings.Button.inCartButton :
      AppDefaults.Strings.Button.toCartButton
    let followTitle = isFollowed ?
      AppDefaults.Strings.Button.unfollowButton :
      AppDefaults.Strings.Button.followButton
    
    mainView.buyButton.setTitle(cartTitle, for: .normal)
    mainView.favouritesButton.setTitle(followTitle, for: .normal)
  }
}

private extension ProductMainInfoCell {
  func setupActions() {
    mainView.buyButton.addAction(for: .touchUpInside) { [unowned self] in
      let productToCart = self.setupProduct()
      self.eventHandler?(.onBuyButtonAction(productToCart))
    }
    
    mainView.favouritesButton.addAction(for: .touchUpInside) { [unowned self] in
      let productToFav = self.setupProduct()
      self.eventHandler?(.onFavButtonAction(productToFav))
    }
  }
  
  func setupProduct() -> ShortProductModel {
    guard let product = product else { return ShortProductModel.newEmpty() }
    return ShortProductModel(id: product.productID,
                             name: product.name,
                             image: product.image,
                             color: mainView.colorPickerView.selectedColor ?? "",
                             quantity: "\(Int(self.mainView.qtyView.value))",
                             price: product.price)
  }
}
