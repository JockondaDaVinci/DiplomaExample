//
//  HomeRouter.swift
//  OrgTech
//
//  Created by Maksym Balukhtin on 22.04.2020.
//  Copyright © 2020 Maksym Balukhtin. All rights reserved.
//

import Foundation

protocol HomeRoute {
  func toProduct(withID id: String)
}

extension HomeRoute where Self: BaseRouter {
  func toProduct(withID id: String) {
    var module = ProductBuilder.create()
    module.presenter.productID = id
    open(module.view.viewController, completion: nil)
  }
}

final class HomeRouter: BaseRouter, HomeRouter.Routes {
  typealias Routes = HomeRoute
}
