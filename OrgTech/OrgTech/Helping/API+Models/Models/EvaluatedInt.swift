//
//  EvaluatedInt.swift
//  OrgTech
//
//  Created by Maksym Balukhtin on 30.04.2020.
//  Copyright © 2020 Maksym Balukhtin. All rights reserved.
//

import Foundation

struct EvaluatedInt: Codable {
  var value: Int?
  
  public init(from decoder: Decoder) throws {
    let container = try decoder.singleValueContainer()
    if let double = try? container.decode(Double.self) {
      self.value = self.convertAnyObjectToInt(double as AnyObject)
    } else if let int = try? container.decode(Int.self) {
      self.value = self.convertAnyObjectToInt(int as AnyObject)
    } else if let float = try? container.decode(Float.self) {
      self.value = self.convertAnyObjectToInt(float as AnyObject)
    } else if let string = try? container.decode(String.self) {
      self.value = self.convertAnyObjectToInt(string as AnyObject)
    }
  }
  
  func convertAnyObjectToInt(_ parameter: AnyObject) -> Int? {
    switch parameter {
    case let a as Int:
      return a
    case let a as Float:
      return Int(a)
    case let a as Double:
      return Int(a)
    case let a as String:
      return a.intValue
    default:
      return nil
    }
  }
}
