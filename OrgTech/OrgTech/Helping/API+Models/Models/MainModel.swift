//
//  MainModel.swift
//  OrgTech
//
//  Created by Maksym Balukhtin on 22.04.2020.
//  Copyright © 2020 Maksym Balukhtin. All rights reserved.
//

import Foundation

protocol MainModelProtocol: Codable {
  var productID: String { get set }
  var brandName: String { get set }
  var name: String { get set }
  var price: EvaluatedInt? { get set }
  var image: String { get set }
  var top: EvaluatedInt? { get set }
  var sale: EvaluatedInt? { get set }
  var color: [String] { get set }
}

struct MainModel: MainModelProtocol {
  //MARK: - Protocol Related
  var productID, brandName, name, image: String
  var top, sale, price: EvaluatedInt?
  var color: [String]
  
  enum CodingKeys: String, CodingKey {
    case productID = "product_id"
    case brandName = "brand_name"
    case name, price, image, top, sale, color
  }
}
