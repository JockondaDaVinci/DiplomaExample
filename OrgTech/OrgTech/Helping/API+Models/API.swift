//
//  API.swift
//  OrgTech
//
//  Created by Maksym Balukhtin on 22.04.2020.
//  Copyright © 2020 Maksym Balukhtin. All rights reserved.
//

import Foundation

enum API {
  static let apiBase = "http://localhost:8888/api"
  
  enum Preffix {
    static let product = "/product"
    static let category = "/category"
  }
  
  enum Suffix {
    static let read = "/read.php"
    static let readOne = "/read_one.php"
    static let search = "/search.php"
    static let select = "/select.php"
    static let sort = "/sort.php"
  }
  
  enum Postfix {
    static let id = "?id="
    static let query = "?s="
    static let categoryID = "?category_id="
  }
}

enum Product {
  static let main = [API.apiBase, API.Preffix.product, API.Suffix.read].joined()
  static let filter = [API.apiBase, API.Preffix.product, API.Suffix.select].joined()
  static func getProduct(byID id: String) -> String {
    return [API.apiBase, API.Preffix.product, API.Suffix.readOne, API.Postfix.id, id].joined()
  }
  static func search(byQuery query: String) -> String {
    return [API.apiBase, API.Preffix.product, API.Suffix.search, API.Postfix.query, query].joined()
  }
}

enum Categories {
  static let main = [API.apiBase, API.Preffix.category, API.Suffix.read].joined()
  static func getCategory(byID id: String) -> String {
    return [API.apiBase, API.Preffix.category, API.Suffix.select, API.Postfix.categoryID, id].joined()
  }
  static func getFilterParameters(forID id: String) -> String {
    return [API.apiBase, API.Preffix.category, API.Suffix.sort, API.Postfix.categoryID, id].joined()
  }
}
