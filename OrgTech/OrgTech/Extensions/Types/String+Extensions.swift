//
//  String+Extensions.swift
//  OrgTech
//
//  Created by Maksym Balukhtin on 30.04.2020.
//  Copyright © 2020 Maksym Balukhtin. All rights reserved.
//

import Foundation

extension String {
  var intValue: Int {
    return (self as NSString).integerValue
  }
  
  var doubleValue: Double {
    return (self as NSString).doubleValue
  }
}
