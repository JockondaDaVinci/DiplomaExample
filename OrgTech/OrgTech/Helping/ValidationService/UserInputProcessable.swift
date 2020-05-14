//
//  UserInputProcessable.swift
//  OrgTech
//
//  Created by Maksym Balukhtin on 02.05.2020.
//  Copyright © 2020 Maksym Balukhtin. All rights reserved.
//

import Foundation

protocol UserInputProcessable: AnyObject {
  func onInteractorInputIsValid(inputType: UserInputType)
  func onInteractorAllInputsAreValid()
  func onInteractorInputIsInvalid(_ error: Error)
}
