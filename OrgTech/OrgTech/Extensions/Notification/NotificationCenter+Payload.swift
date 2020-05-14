//
//  NotificationCenter+Payload.swift
//  OrgTech
//
//  Created by Maksym Balukhtin on 02.05.2020.
//  Copyright © 2020 Maksym Balukhtin. All rights reserved.
//

import UIKit

struct NotificationDescriptor<Payload> {
  let name: Notification.Name
  let convert: (Notification) -> Payload
}

extension NotificationCenter {
  func addObserver<Payload>(with descriptor: NotificationDescriptor<Payload>, block: @escaping (Payload) -> Void) -> NSObjectProtocol {
    return addObserver(with: descriptor) { payload, _ in
      block(payload)
    }
  }
  
  func addObserver<Payload>(with descriptor: NotificationDescriptor<Payload>, block: @escaping (Payload, Notification.Name) -> Void) -> NSObjectProtocol {
    return addObserver(forName: descriptor.name, object: nil, queue: nil) { note in
      block(descriptor.convert(note), note.name)
    }
  }
}

struct KeyboardPayload {
  let beginFrame: CGRect
  let endFrame: CGRect
  let curve: UIView.AnimationCurve
  let duration: TimeInterval
  let isLocal: Bool
}

extension KeyboardPayload {
  init(note: Notification) {
    let userInfo = note.userInfo
    beginFrame = userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as! CGRect
    endFrame = userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
    curve = UIView.AnimationCurve(rawValue: userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as! Int)!
    duration = userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as! TimeInterval
    isLocal = userInfo?[UIResponder.keyboardIsLocalUserInfoKey] as! Bool
  }
}

extension UIViewController {
  static let keyboardWillShow = NotificationDescriptor(name: UIResponder.keyboardWillShowNotification,
                                                       convert: KeyboardPayload.init)
  static let keyboardWillHide = NotificationDescriptor(name: UIResponder.keyboardWillHideNotification,
                                                       convert: KeyboardPayload.init)
}

extension UIViewController {
  func layoutViewAnimated(withDuration duration: TimeInterval) {
    UIView.animate(withDuration: duration) {
      self.view.layoutIfNeeded()
    }
  }
}

