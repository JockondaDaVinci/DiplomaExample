//
//  UIControl+Closure.swift
//  FannexSDK
//
//  Created by Maksym Balukhtin on 7/18/19.
//

import UIKit

typealias VoidClosure = () -> Void
typealias EventHandler<T> = ((T) -> Void)

private class ClosureSleeve {
  let closure: VoidClosure?
  
  init (_ closure: VoidClosure?) {
    self.closure = closure
  }
  
  @objc func invoke () {
    closure?()
  }
}

extension UIControl {
  @objc func addAction(for controlEvent: UIControl.Event, action: VoidClosure?) {
    let sleeve = ClosureSleeve(action)
    addTarget(sleeve, action: #selector(ClosureSleeve.invoke), for: controlEvent)
    objc_setAssociatedObject(self, String(format: "[%d]", arc4random()), sleeve, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
  }
}
