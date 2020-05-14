//
//  CategoryContentModel.swift
//  OrgTech
//
//  Created by Maksym Balukhtin on 29.04.2020.
//  Copyright © 2020 Maksym Balukhtin. All rights reserved.
//

import Foundation

struct CategoryContentModel: MainModelProtocol {
  //MARK: - Protocol Related
  var productID, brandName, name, image: String
  var top, sale, price: EvaluatedInt?
  var color: [String]
  
  //MARK: - Model Related
  var categoryID, categoryName: String
  
  enum CodingKeys: String, CodingKey {
    case productID = "product_id"
    case brandName = "brand_name"
    case name, price, image, top, sale, color
    
    case categoryID = "category_id"
    case categoryName = "category_name"
  }
}
