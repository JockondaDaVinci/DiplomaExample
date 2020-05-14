//
//  ProductModel.swift
//  OrgTech
//
//  Created by Maksym Balukhtin on 22.04.2020.
//  Copyright © 2020 Maksym Balukhtin. All rights reserved.
//

import Foundation

struct ProductModel: MainModelProtocol {
  //MARK: - Protocol Related
  var productID, brandName, name, image: String
  var top, sale, price: EvaluatedInt?
  var color: [String]
  
  //MARK: - Model Related
  var description, quantity: String
  var rating: EvaluatedInt
  var reviews: [ReviewModel]
  
  enum CodingKeys: String, CodingKey {
    case productID = "product_id"
    case brandName = "brand_name"
    case name, price, image, top, sale, color
    
    case description, quantity, rating, reviews
  }
}


struct ShortProductModel: Codable {
  let id, name, image: String
  let color, quantity: String?
  let price: EvaluatedInt?
  
  static func newEmpty() -> ShortProductModel {
    return ShortProductModel(id: "", name: "", image: "", color: "", quantity: nil, price: nil)
  }
  
  static func ==(lhs: ShortProductModel, rhs: ShortProductModel) -> Bool {
    return lhs.id == rhs.id
  }
}
