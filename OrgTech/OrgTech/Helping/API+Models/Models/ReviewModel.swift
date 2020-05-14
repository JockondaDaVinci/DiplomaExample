//
//  ReviewModel.swift
//  OrgTech
//
//  Created by Maksym Balukhtin on 22.04.2020.
//  Copyright © 2020 Maksym Balukhtin. All rights reserved.
//

import Foundation

struct ReviewModel: Codable {
  let autor, review: String?
  let rating: EvaluatedInt?
}
