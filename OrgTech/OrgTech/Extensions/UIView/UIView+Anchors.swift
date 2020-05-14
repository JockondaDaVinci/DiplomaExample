//
//  UIView+Anchors.swift
//  FannexSDK
//
//  Created by Maksym Balukhtin on 7/16/19.
//  Copyright © 2019 Maksym Balukhtin. All rights reserved.
//

import UIKit
import Foundation

typealias ViewAnchors = (top: NSLayoutConstraint?, left: NSLayoutConstraint?, bottom: NSLayoutConstraint?, right: NSLayoutConstraint?, width: NSLayoutConstraint?, height: NSLayoutConstraint?)

extension UIView {
  func fillSuperview(with constant: CGFloat = 0) {
    translatesAutoresizingMaskIntoConstraints = false
    if let superview = superview {
      leftAnchor.constraint(equalTo: superview.leftAnchor, constant: constant).isActive = true
      rightAnchor.constraint(equalTo: superview.rightAnchor, constant: -constant).isActive = true
      topAnchor.constraint(equalTo: superview.topAnchor, constant: constant).isActive = true
      bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -constant).isActive = true
    }
  }
  
  @discardableResult
  func anchorCenterXToSuperview(_ constant: CGFloat = 0) -> UIView {
    translatesAutoresizingMaskIntoConstraints = false
    if let anchor = superview?.centerXAnchor {
      centerXAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
    }
    return self
  }
  
  @discardableResult
  func anchorCenterXToView(_ view: UIView, constant: CGFloat = 0) -> UIView {
    translatesAutoresizingMaskIntoConstraints = false
    let anchor = view.centerXAnchor
    centerXAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
    return self
  }
  
  @discardableResult
  func anchorCenterYToView(_ view: UIView, constant: CGFloat = 0) -> UIView {
    translatesAutoresizingMaskIntoConstraints = false
    let anchor = view.centerYAnchor
    centerYAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
    return self
  }
  
  @discardableResult
  func anchorCenterYToSuperview(_ constant: CGFloat = 0) -> UIView {
    translatesAutoresizingMaskIntoConstraints = false
    if let anchor = superview?.centerYAnchor {
      centerYAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
    }
    return self
  }
  
  @discardableResult
  func anchorCenterSuperview() -> UIView {
    anchorCenterXToSuperview()
    anchorCenterYToSuperview()
    return self
  }
  
  @discardableResult
  func anchorTop(_ top: NSLayoutYAxisAnchor, _ constant: CGFloat, relation: NSLayoutConstraint.Relation = .equal, priority: UILayoutPriority = .required) -> UIView {
    _ = _anchorTop(top, constant, relation: relation, priority: priority)
    return self
  }
  
  @discardableResult
  func anchorBottom(_ bottom: NSLayoutYAxisAnchor, _ constant: CGFloat, relation: NSLayoutConstraint.Relation = .equal, priority: UILayoutPriority = .required) -> UIView {
    _ = _anchorBottom(bottom, constant, relation: relation, priority: priority)
    return self
  }
  
  @discardableResult
  func anchorLeft(_ left: NSLayoutXAxisAnchor, _ constant: CGFloat, relation: NSLayoutConstraint.Relation = .equal, priority: UILayoutPriority = .required) -> UIView {
    _ = _anchorLeft(left, constant, relation: relation, priority: priority)
    return self
  }
  
  @discardableResult
  func anchorRight(_ right: NSLayoutXAxisAnchor, _ constant: CGFloat, relation: NSLayoutConstraint.Relation = .equal, priority: UILayoutPriority = .required) -> UIView {
    _ = _anchorRight(right, constant, relation: relation, priority: priority)
    return self
  }
  
  @discardableResult
  func anchorWidth(_ constant: CGFloat, relation: NSLayoutConstraint.Relation = .equal, priority: UILayoutPriority = .required) -> UIView {
    _ = _anchorWidth(constant, relation: relation, priority: priority)
    return self
  }
  
  @discardableResult
  func anchorHeight(_ constant: CGFloat, relation: NSLayoutConstraint.Relation = .equal, priority: UILayoutPriority = .required) -> UIView {
    _ = _anchorHeight(constant, relation: relation, priority: priority)
    return self
  }
  
  @discardableResult
  func anchorEqualWidth(_ width: NSLayoutDimension, relation: NSLayoutConstraint.Relation = .equal, priority: UILayoutPriority = .required) -> UIView {
    translatesAutoresizingMaskIntoConstraints = false
    
    let anchor = widthAnchor.constraint(equalTo: width, multiplier: 1.0)
    anchor.priority = priority
    anchor.isActive = true
    return self
  }
  
  @discardableResult
  func anchorEqualHeight(_ height: NSLayoutDimension, priority: UILayoutPriority = .required) -> UIView {
    translatesAutoresizingMaskIntoConstraints = false
    
    let anchor = heightAnchor.constraint(equalTo: height, multiplier: 1.0)
    anchor.priority = priority
    anchor.isActive = true
    return self
  }
}

extension UIView {
  func _anchorTop(_ top: NSLayoutYAxisAnchor, _ constant: CGFloat, relation: NSLayoutConstraint.Relation = .equal, priority: UILayoutPriority = .required) -> NSLayoutConstraint {
    translatesAutoresizingMaskIntoConstraints = false
    
    var anchor: NSLayoutConstraint
    switch relation {
    case .greaterThanOrEqual:
      anchor = topAnchor.constraint(greaterThanOrEqualTo: top, constant: constant)
    case .lessThanOrEqual:
      anchor = topAnchor.constraint(lessThanOrEqualTo: top, constant: constant)
    default:
      anchor = topAnchor.constraint(equalTo: top, constant: constant)
    }
    
    anchor.priority = priority
    anchor.isActive = true
    return anchor
  }
  
  func _anchorBottom(_ bottom: NSLayoutYAxisAnchor, _ constant: CGFloat, relation: NSLayoutConstraint.Relation = .equal, priority: UILayoutPriority = .required) -> NSLayoutConstraint {
    translatesAutoresizingMaskIntoConstraints = false
    
    var anchor: NSLayoutConstraint
    switch relation {
    case .greaterThanOrEqual:
      anchor = bottomAnchor.constraint(greaterThanOrEqualTo: bottom, constant: -constant)
    case .lessThanOrEqual:
      anchor = bottomAnchor.constraint(lessThanOrEqualTo: bottom, constant: -constant)
    default:
      anchor = bottomAnchor.constraint(equalTo: bottom, constant: -constant)
    }
    
    anchor.priority = priority
    anchor.isActive = true
    return anchor
  }
  
  func _anchorLeft(_ left: NSLayoutXAxisAnchor, _ constant: CGFloat, relation: NSLayoutConstraint.Relation = .equal, priority: UILayoutPriority = .required) -> NSLayoutConstraint {
    translatesAutoresizingMaskIntoConstraints = false
    
    var anchor: NSLayoutConstraint
    switch relation {
    case .greaterThanOrEqual:
      anchor = leftAnchor.constraint(greaterThanOrEqualTo: left, constant: constant)
    case .lessThanOrEqual:
      anchor = leftAnchor.constraint(lessThanOrEqualTo: left, constant: constant)
    default:
      anchor = leftAnchor.constraint(equalTo: left, constant: constant)
    }
    
    anchor.priority = priority
    anchor.isActive = true
    return anchor
  }
  
  func _anchorRight(_ right: NSLayoutXAxisAnchor, _ constant: CGFloat, relation: NSLayoutConstraint.Relation = .equal, priority: UILayoutPriority = .required) -> NSLayoutConstraint {
    translatesAutoresizingMaskIntoConstraints = false
    
    var anchor: NSLayoutConstraint
    switch relation {
    case .greaterThanOrEqual:
      anchor = rightAnchor.constraint(greaterThanOrEqualTo: right, constant: -constant)
    case .lessThanOrEqual:
      anchor = rightAnchor.constraint(lessThanOrEqualTo: right, constant: -constant)
    default:
      anchor = rightAnchor.constraint(equalTo: right, constant: -constant)
    }
    
    anchor.priority = priority
    anchor.isActive = true
    return anchor
  }
  
  func _anchorWidth(_ constant: CGFloat, relation: NSLayoutConstraint.Relation = .equal, priority: UILayoutPriority = .required) -> NSLayoutConstraint {
    translatesAutoresizingMaskIntoConstraints = false
    
    var anchor: NSLayoutConstraint
    switch relation {
    case .greaterThanOrEqual:
      anchor = widthAnchor.constraint(greaterThanOrEqualToConstant: constant)
    case .lessThanOrEqual:
      anchor = widthAnchor.constraint(lessThanOrEqualToConstant: constant)
    default:
      anchor = widthAnchor.constraint(equalToConstant: constant)
    }
    
    anchor.priority = priority
    anchor.isActive = true
    return anchor
  }
  
  func _anchorHeight(_ constant: CGFloat, relation: NSLayoutConstraint.Relation = .equal, priority: UILayoutPriority = .required) -> NSLayoutConstraint {
    translatesAutoresizingMaskIntoConstraints = false
    
    var anchor: NSLayoutConstraint
    switch relation {
    case .greaterThanOrEqual:
      anchor = heightAnchor.constraint(greaterThanOrEqualToConstant: constant)
    case .lessThanOrEqual:
      anchor = heightAnchor.constraint(lessThanOrEqualToConstant: constant)
    default:
      anchor = heightAnchor.constraint(equalToConstant: constant)
    }
    
    anchor.priority = priority
    anchor.isActive = true
    return anchor
  }
}

protocol LayoutGuideProvider {
  var leadingAnchor: NSLayoutXAxisAnchor { get }
  var trailingAnchor: NSLayoutXAxisAnchor { get }
  var leftAnchor: NSLayoutXAxisAnchor { get }
  var rightAnchor: NSLayoutXAxisAnchor { get }
  var topAnchor: NSLayoutYAxisAnchor { get }
  var bottomAnchor: NSLayoutYAxisAnchor { get }
  var widthAnchor: NSLayoutDimension { get }
  var heightAnchor: NSLayoutDimension { get }
  var centerXAnchor: NSLayoutXAxisAnchor { get }
  var centerYAnchor: NSLayoutYAxisAnchor { get }
}

extension UIView: LayoutGuideProvider { }
extension UILayoutGuide: LayoutGuideProvider { }

extension UIView {
  var safeAreaLayoutGuideAnyIOS: LayoutGuideProvider {
    if #available(iOS 11, *) {
      return safeAreaLayoutGuide
    } else {
      return self
    }
  }
  
  var safeAreaInsetsAnyIOS: UIEdgeInsets? {
    if #available(iOS 11, *) {
      return safeAreaInsets
    } else {
      return nil
    }
  }
}
