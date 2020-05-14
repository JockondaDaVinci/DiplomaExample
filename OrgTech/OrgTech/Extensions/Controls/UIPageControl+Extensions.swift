//
//  UIPageControl+Extensions.swift
//  OrgTech
//
//  Created by Maksym Balukhtin on 16.02.2020.
//  Copyright © 2020 Maksym Balukhtin. All rights reserved.
//

import UIKit

public protocol PageIndicatorView: class {
  var view: UIView { get }
  var page: Int { get set }
  var numberOfPages: Int { get set}
}

extension UIPageControl: PageIndicatorView {
  public var view: UIView {
    currentPageIndicatorTintColor = AppDefaults.Colors.PageIndicator.current
    pageIndicatorTintColor = AppDefaults.Colors.PageIndicator.default
    return self
  }
  
  public var page: Int {
    get {
      return currentPage
    }
    set {
      currentPage = newValue
    }
  }
  
  open override func sizeToFit() {
    var frame = self.frame
    frame.size = size(forNumberOfPages: numberOfPages)
    frame.size.height = 30
    self.frame = frame
  }
}
