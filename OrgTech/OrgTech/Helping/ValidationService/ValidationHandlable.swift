//
//  ValidationHandlable.swift
//  OrgTech
//
//  Created by Maksym Balukhtin on 02.05.2020.
//  Copyright © 2020 Maksym Balukhtin. All rights reserved.
//

import UIKit

protocol ValidationHandlable {
  func showInputErrorMessage(inputType: UserInputType, message: String)
  func hideInputErrorMessage(inputType: UserInputType)
  func toggleButton(isEnabled: Bool)
}
