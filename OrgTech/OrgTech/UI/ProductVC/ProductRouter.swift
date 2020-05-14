//
//  ProductRouter.swift
//  OrgTech
//
//  Created by Maksym Balukhtin on 22.04.2020.
//  Copyright © 2020 Maksym Balukhtin. All rights reserved.
//

import UIKit

protocol ProductRoute {
  func toAddReview()
}

extension ProductRoute where Self: BaseRouter {
  func toAddReview() {
    let module = AddReviewBuilder.create()
    open(module.view.viewController, completion: nil, embeded: true)
  }
}

final class ProductRouter: BaseRouter, ProductRouter.Routes {
  typealias Routes = ProductRoute
}
