//
//  AddReviewInteractor.swift
//  OrgTech
//
//  Created by Maksym Balukhtin on 29.04.2020.
//  Copyright © 2020 Maksym Balukhtin. All rights reserved.
//

import Foundation

protocol AddReviewPresenterToInteractor: UserInputValidatable {
  
}


final class AddReviewInteractor {
  var presenter: AddReviewInteractorToPresenter?
  var validationService: UserInputValidationServiceProtocol!
}


extension AddReviewInteractor: AddReviewPresenterToInteractor {
  
}

extension AddReviewInteractor: UserInputValidatable {
  var inputProcesser: UserInputProcessable? { return presenter }
}
