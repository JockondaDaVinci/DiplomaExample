//
//  CartRouter.swift
//  OrgTech
//
//  Created by Maksym Balukhtin on 22.04.2020.
//  Copyright © 2020 Maksym Balukhtin. All rights reserved.
//

import UIKit

protocol CartRoute {
  func toConfirm()
}

extension CartRoute where Self: BaseRouter {
  func toConfirm() {
    let module = ConfirmPurchaseBuilder.create()
    open(module.view.viewController, completion: nil, embeded: true)
  }
}

final class CartRouter: BaseRouter, CartRouter.Routes {
  typealias Routes = CartRoute
}
