//
//  MenuRouter.swift
//  OrgTech
//
//  Created by Maksym Balukhtin on 22.04.2020.
//  Copyright © 2020 Maksym Balukhtin. All rights reserved.
//

import UIKit

protocol MenuRoute {
  func toCategory(withID id: String)
  func toFavourites()
}

extension MenuRoute where Self: BaseRouter {
  func toCategory(withID id: String) {
    var module = CategoryBuilder.create()
    module.presenter.categoryID = id
    open(module.view.viewController, completion: nil)
  }
  
  func toFavourites() {
    let module = FavouritesBuilder.create()
    open(module.view.viewController, completion: nil)
  }
}

final class MenuRouter: BaseRouter, MenuRouter.Routes {
  typealias Routes = MenuRoute
}
