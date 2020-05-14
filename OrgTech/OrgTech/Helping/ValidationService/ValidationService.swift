//
//  ValidationService.swift
//  OrgTech
//
//  Created by Maksym Balukhtin on 02.05.2020.
//  Copyright © 2020 Maksym Balukhtin. All rights reserved.
//
import Foundation

enum UserInputType {
  case email(String?)
  case userName(String?)
  case review(ReviewInput)
  case confirmPurchase(ConfirmPurchaseInput)
}

enum ReviewInput {
  case userName(String?)
  case comment(String?)
  case rating(Int?)
}

enum ConfirmPurchaseInput {
  case email(String?)
  case userName(String?)
  case address(String?)
  case deliveryType(String?)
}

protocol UserInputValidationServiceProtocol {
  func validateEmail(_ email: String?) throws
  func validateUserName(_ userName: String?) throws
  func validateReviewInputs(_ review: ReviewInput) throws
  func validateConfirmPurchaseInputs(_ inputs: ConfirmPurchaseInput) throws
}

enum ValidationServiceError: Error, Hashable {
  case invalidInput(UserInputType)
  case emptyInput(UserInputType)
  
  func hash(into hasher: inout Hasher) {
    hasher.combine(String(describing: self))
  }
}

extension ValidationServiceError: Equatable {
  static func == (lhs: ValidationServiceError, rhs: ValidationServiceError) -> Bool {
    return lhs.hashValue == rhs.hashValue
  }
}

extension ValidationServiceError: LocalizedError {
  public var errorDescription: String? {
    switch self {
    case .invalidInput(let inputType):
      switch inputType {
      case .email:
        return "Invalid email"
      case .userName:
        return "Invalid name"
      case .review(let reviewInput):
        switch reviewInput {
        case .comment:
          return "Incorrect comment"
        case .rating:
          return ""
        default:
          return String(describing: self)
        }
      case .confirmPurchase(let inputs):
        switch inputs {
        case .address:
          return "Invalid address"
        case .deliveryType:
          return "Invalid delivery type"
        default:
          return String(describing: self)
        }
      }
    default:
      return String(describing: self)
    }
  }
}

final class UserInputValidationService: UserInputValidationServiceProtocol {
  func validateEmail(_ email: String?) throws  {
    guard let email = email, !email.isEmpty else {
      throw ValidationServiceError.emptyInput(.email(nil))
    }
    
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
    let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    
    let isValidEmail = emailTest.evaluate(with: email)
    if !isValidEmail { throw ValidationServiceError.invalidInput(.email(email)) }
  }
  
  func validateUserName(_ userName: String?) throws {
    let regEx = "^[A-Za-zА-Яа-я]{2,50}$"
    let userNameTest = NSPredicate(format: "SELF MATCHES %@", regEx)
    guard let name = userName, !name.isEmpty else {
      throw ValidationServiceError.emptyInput(.userName(nil))
    }
    let isValid = userNameTest.evaluate(with: name)
    if !isValid { throw ValidationServiceError.invalidInput(.userName(name)) }
  }
  
  func validateReviewInputs(_ review: ReviewInput) throws {
    switch review {
    case .userName(let name):
      try validateUserName(name)
    case .comment(let comment):
      guard let comment = comment, !comment.isEmpty else {
        throw ValidationServiceError.emptyInput(.review(.comment(nil)))
      }
    case .rating(let rating):
      guard let rating = rating, rating > 0 else {
        throw ValidationServiceError.emptyInput(.review(.rating(nil)))
      }
    }
  }
  
  func validateConfirmPurchaseInputs(_ inputs: ConfirmPurchaseInput) throws {
    switch inputs {
    case .email(let email):
      try validateEmail(email)
    case .userName(let name):
      try validateUserName(name)
    case .address(let address):
      guard let address = address, !address.isEmpty else {
        throw ValidationServiceError.emptyInput(.confirmPurchase(.address(nil)))
      }
    case .deliveryType(let deliveryType):
      guard let deliveryType = deliveryType, !deliveryType.isEmpty else {
        throw ValidationServiceError.emptyInput(.confirmPurchase(.deliveryType(nil)))
      }
    }
  }
}


