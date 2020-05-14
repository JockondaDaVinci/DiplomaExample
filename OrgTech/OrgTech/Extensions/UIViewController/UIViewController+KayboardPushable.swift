//
//  UIViewController+KayboardPushable.swift
//  OrgTech
//
//  Created by Maksym Balukhtin on 02.05.2020.
//  Copyright © 2020 Maksym Balukhtin. All rights reserved.
//

import UIKit

protocol KeyboardPushable: AnyObject {
  /**
   Bind constraint to be "pushed" by the keyboard.
   Constraint value will be increased by the keyboard height while keyboard is show and decreased to the same value while keyboard is hidden.
   
   Parameter constraint: The constraint to be pushed by keyboard.
   */
  func adjustConstraintForKeyboard(_ constraint: NSLayoutConstraint?)
  func keyboardTrigger(keyboardShown: @escaping (CGFloat) -> Void,
                       keyboardHidden: @escaping () -> Void)
  
  /**
   Unsubscribe from keyboard notifications.
   - Attention: Must call in the `deinit`.
   */
  func cleanUpObservers()
}

private var willShowKey: UInt8 = 0
private var willHideKey: UInt8 = 1
private var keyboardOffsetKey: UInt8 = 2

extension KeyboardPushable where Self: UIViewController {
  private var willShowObserver: NSObjectProtocol? {
    get {
      return objc_getAssociatedObject(self, &willShowKey) as? NSObjectProtocol
    }
    set {
      objc_setAssociatedObject(self, &willShowKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
  }
  
  private var willHideObserver: NSObjectProtocol? {
    get {
      return objc_getAssociatedObject(self, &willHideKey) as? NSObjectProtocol
    }
    set {
      objc_setAssociatedObject(self, &willHideKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
  }
  
  private var initialValue: CGFloat? {
    get {
      return objc_getAssociatedObject(self, &keyboardOffsetKey) as? CGFloat
    }
    set {
      objc_setAssociatedObject(self, &keyboardOffsetKey, newValue, .OBJC_ASSOCIATION_ASSIGN)
    }
  }
  
  func keyboardTrigger(keyboardShown: @escaping (CGFloat) -> Void,
                       keyboardHidden: @escaping () -> Void) {
    willShowObserver = NotificationCenter.default.addObserver(with: UIViewController.keyboardWillShow, block: { [weak self] payload in
      guard let _self = self else { return }
      var offset: CGFloat = 0.0
      if #available(iOS 11.0, *) {
        offset = _self.view.safeAreaInsets.bottom
      }
      
      let value = payload.endFrame.size.height - offset
      _self.layoutViewAnimated(withDuration: payload.duration)
      
      keyboardShown(value)
    })
    
    willHideObserver = NotificationCenter.default.addObserver(with:
      
      UIViewController.keyboardWillHide, block: { [weak self] payload in
      guard let _self = self else { return }
      if let value = _self.initialValue {
        keyboardShown(value)
      } else {
        keyboardHidden()
      }
      _self.layoutViewAnimated(withDuration: payload.duration)
    })
  }
  
  func adjustConstraintForKeyboard(_ constraint: NSLayoutConstraint?) {
    guard let constraint = constraint else { return }

    willShowObserver = NotificationCenter.default.addObserver(with: UIViewController.keyboardWillShow, block: { [weak self] payload in
      guard let _self = self else { return }
      var offset: CGFloat = 0.0
      if #available(iOS 11.0, *) {
        offset = _self.view.safeAreaInsets.bottom
      }
      
      constraint.constant = -(payload.endFrame.size.height - offset)
      _self.layoutViewAnimated(withDuration: payload.duration)
    })
    
    willHideObserver = NotificationCenter.default.addObserver(with: UIViewController.keyboardWillHide, block: { [weak self] payload in
      guard let _self = self else { return }
      if let value = _self.initialValue {
        constraint.constant = value
      } else {
        constraint.constant = 0
      }
      _self.layoutViewAnimated(withDuration: payload.duration)
    })
  }
  
  func cleanUpObservers() {
    if let willShowObserver = willShowObserver {
      NotificationCenter.default.removeObserver(willShowObserver)
    }
    if let willHideObserver = willHideObserver {
      NotificationCenter.default.removeObserver(willHideObserver)
    }
    NotificationCenter.default.removeObserver(self)
  }
}
