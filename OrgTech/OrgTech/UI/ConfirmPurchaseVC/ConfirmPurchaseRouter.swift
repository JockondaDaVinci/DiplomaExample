//
//  ConfirmPurchaseRouter.swift
//  OrgTech
//
//  Created by Maksym Balukhtin on 29.04.2020.
//  Copyright © 2020 Maksym Balukhtin. All rights reserved.
//

import UIKit

protocol ConfirmPurchaseRoute {
  func close()
}

extension ConfirmPurchaseRoute where Self: BaseRouter {
  func close() {
    close(completion: nil)
  }
}

final class ConfirmPurchaseRouter: BaseRouter, ConfirmPurchaseRouter.Routes {
  typealias Routes = ConfirmPurchaseRoute
}
