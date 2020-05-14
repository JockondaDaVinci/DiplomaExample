//
//  BaseBuilder.swift
//  FannexSDK
//
//  Created by Maksym Balukhtin on 7/19/19.
//

import Foundation

protocol BaseBuilder {
  associatedtype PresenterType
  static func create() -> (presenter: PresenterType, view: Modulable, router: BaseRouter)
}

protocol Inputs { }


