//
//  CategoryRouter.swift
//  OrgTech
//
//  Created by Maksym Balukhtin on 29.04.2020.
//  Copyright © 2020 Maksym Balukhtin. All rights reserved.
//

import UIKit

protocol CategoryRoute {
  func toProduct(withID id: String)
  func toFilter(withID id: String, delegate: FilterInputsDelegate)
}

extension CategoryRoute where Self: BaseRouter {
  func toProduct(withID id: String) {
    var module = ProductBuilder.create()
    module.presenter.productID = id
    open(module.view.viewController, completion: nil)
  }
  
  func toFilter(withID id: String, delegate: FilterInputsDelegate) {
    var module = FilterBuilder.create()
    module.presenter.categoryID = id
    module.presenter.delegate = delegate
    open(module.view.viewController, completion: nil, embeded: true)
  }
}

final class CategoryRouter: BaseRouter, CategoryRouter.Routes {
  typealias Routes = CategoryRoute
}
