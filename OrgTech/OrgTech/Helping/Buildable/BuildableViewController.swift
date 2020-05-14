//
//  BuildableViewController.swift
//  FannexSDK
//
//  Created by Maksym Balukhtin on 7/18/19.
//

import UIKit

protocol Modulable {
  var viewController: UIViewController { get }
}

extension UIViewController: Modulable { }

extension Modulable where Self: UIViewController {
  var viewController: UIViewController { return self }
}

class BuildableViewController<View: UIView>: UIViewController, KeyboardPushable {
  var mainView: View
  
  override func loadView() {
    view = mainView
  }
  
  init(view: View = View()) {
    mainView = view
    super.init(nibName: nil, bundle: nil)
  }
  
  @available(*, unavailable) required init?(coder aDecoder: NSCoder) {
    fatalError("Use init() instead")
  }
  
  var isKeyboardHandlable = false {
    didSet {
      if isKeyboardHandlable {
        assignClosing()
      }
    }
  }
  
  private func assignClosing() {
    let tap = UITapGestureRecognizer(target: self, action: #selector(closeKeyboard))
    tap.cancelsTouchesInView = false
    mainView.addGestureRecognizer(tap)
  }
  
  @objc func closeKeyboard() {
    let view = navigationController?.view ?? mainView
    view.endEditing(true)
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    if #available(iOS 11, *) { } else {
      navigationController?.navigationBar.isTranslucent = false
    }
  }
  
  deinit {
    cleanUpObservers()
  }
}
