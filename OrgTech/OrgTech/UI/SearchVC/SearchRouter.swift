//
//  SearchRouter.swift
//  OrgTech
//
//  Created by Maksym Balukhtin on 22.04.2020.
//  Copyright © 2020 Maksym Balukhtin. All rights reserved.
//

import UIKit

protocol SearchRoute {
  func toProduct(withID id: String)
}

extension SearchRoute where Self: BaseRouter {
  func toProduct(withID id: String) {
    var module = ProductBuilder.create()
    module.presenter.productID = id
    open(module.view.viewController, completion: nil)
  }
}

final class SearchRouter: BaseRouter, SearchRouter.Routes {
  typealias Routes = SearchRoute
}
