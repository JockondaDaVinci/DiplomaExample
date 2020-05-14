//
//  FitlerModels.swift
//  OrgTech
//
//  Created by Maksym Balukhtin on 29.04.2020.
//  Copyright © 2020 Maksym Balukhtin. All rights reserved.
//

import Foundation

struct FilterGetModel: Codable {
  let categoryID, categoryName: String
  let brandName, color: [String]
  let minPrice, maxPrice: String
  
  enum CodingKeys: String, CodingKey {
    case categoryID = "category_id"
    case categoryName = "category_name"
    case brandName = "brand_name"
    case color
    case minPrice = "min_price"
    case maxPrice = "max_price"
  }
}

struct FilterPostModel: JSONEncodable {
  var categoryID: Int
  var min, max: Int?
  var color, brandName: String?
  
  static func newEmpty(_ categoryID: Int) -> FilterPostModel {
    return FilterPostModel(categoryID: categoryID, min: nil, max: nil, color: nil, brandName: nil)
  }
  
  func toJSONData() -> Data? {
    let encoder = JSONEncoder()
    do {
      return try encoder.encode(self)
    } catch {
      return nil
    }
  }
  
  enum CodingKeys: String, CodingKey {
    case categoryID = "category_id"
    case brandName = "brand_name"
    case min, max, color
  }
}
