//
//  CategoryModel.swift
//  OrgTech
//
//  Created by Maksym Balukhtin on 22.04.2020.
//  Copyright © 2020 Maksym Balukhtin. All rights reserved.
//

import Foundation

struct CategoryModel: Codable {
  let categoryID, name: String
  let isStatic: Bool?
  
  enum CodingKeys: String, CodingKey {
    case categoryID = "category_id"
    case name
    case isStatic
  }
}
