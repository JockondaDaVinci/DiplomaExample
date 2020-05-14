//
//  FilterRouter.swift
//  OrgTech
//
//  Created by Maksym Balukhtin on 30.04.2020.
//  Copyright © 2020 Maksym Balukhtin. All rights reserved.
//

import UIKit

protocol FilterRoute {
  func close()
}

extension FilterRoute where Self: BaseRouter {
  func close() {
    close(completion: nil)
  }
}

final class FilterRouter: BaseRouter, FilterRouter.Routes {
  typealias Routes = FilterRoute
}
