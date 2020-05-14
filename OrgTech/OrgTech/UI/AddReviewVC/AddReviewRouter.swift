//
//  AddReviewRouter.swift
//  OrgTech
//
//  Created by Maksym Balukhtin on 29.04.2020.
//  Copyright © 2020 Maksym Balukhtin. All rights reserved.
//

import UIKit

protocol AddReviewRoute {
  func close()
}

extension AddReviewRoute where Self: BaseRouter {
  func close() {
    close(completion: nil)
  }
}

final class AddReviewRouter: BaseRouter, AddReviewRouter.Routes {
  typealias Routes = AddReviewRoute
}
