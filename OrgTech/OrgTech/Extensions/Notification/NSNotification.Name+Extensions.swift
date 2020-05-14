//
//  NSNotification.Name+Extensions.swift
//  OrgTech
//
//  Created by Maksym Balukhtin on 30.04.2020.
//  Copyright © 2020 Maksym Balukhtin. All rights reserved.
//

import UIKit

extension NSNotification.Name {
  static let itemAddedToCart = NSNotification.Name("itemAddedToCart")
  static let itemAddedToFavourites = NSNotification.Name("itemAddedToFavourites")
  static let getFilteredItems = NSNotification.Name("getFilteredItems")
  static let cartEmptied = NSNotification.Name("cartEmptied")
}
