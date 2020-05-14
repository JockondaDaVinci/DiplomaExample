//
//  ColorPickerView.swift
//  OrgTech
//
//  Created by Maksym Balukhtin on 23.04.2020.
//  Copyright © 2020 Maksym Balukhtin. All rights reserved.
//

import UIKit

final class ColorPickerView: BuildableView {
  private let scrollView = UIScrollView()
  private var alternatives = [ColorButton]()
  
  var preSelected = false {
    didSet {
      alternatives.first?.isSelected = preSelected
      alternatives.forEach {
        $0.isUserInteractionEnabled = preSelected
      }
    }
  }
  
  var eventHandler: EventHandler<String>?
  
  var selectedColor: String? {
    return alternatives.first(where: { $0.isSelected })?.relatedColor
  }
  
  override func addViews() {
    [scrollView].forEach {
      addSubview($0)
    }
  }
  
  override func anchorViews() {
    scrollView.fillSuperview()
  }
  
  override func configureViews() {
    scrollView.showsVerticalScrollIndicator = false
    scrollView.showsHorizontalScrollIndicator = false
  }
  
  func fill(with colors: [String]) {
    if colors.count <= 3 {
      scrollView.isScrollEnabled = false
    }
    
    if colors.count == 1 {
      fillSingle(colors.first)
      return
    }
    
    var leftButton = ColorButton()
    
    alternatives = colors.enumerated().map { index, alt -> ColorButton in
      let button = ColorButton()
      
      scrollView.addSubview(button)
      
      button.backgroundColor = UIColor(hex: alt)
      
      button
        .anchorLeft(index == 0 ? scrollView.leftAnchor : leftButton.rightAnchor, 5.0)
        .anchorEqualHeight(scrollView.heightAnchor)
        .anchorEqualWidth(button.heightAnchor)
      
      if index == colors.count - 1 {
        button.anchorRight(scrollView.rightAnchor, 5.0)
      }
      
      button.addTarget(self, action: #selector(buttonAction(_:)), for: .touchUpInside)
      
      leftButton = button
      return button
    }
  }
  
  private func fillSingle(_ color: String?) {
    guard let color = color else { return }
    
    let button = ColorButton()
    scrollView.addSubview(button)
    button.backgroundColor = UIColor(hex: color)
    button
      .anchorTop(scrollView.topAnchor, 0.0)
      .anchorBottom(scrollView.bottomAnchor, 0.0)
      .anchorEqualHeight(scrollView.heightAnchor)
      .anchorEqualWidth(button.heightAnchor)
      .anchorCenterXToSuperview()
    
    alternatives.append(button)
  }
  
  @objc func buttonAction(_ sender: ColorButton) {
    alternatives.forEach {
      $0.isSelected = $0 == sender
    }
    
    eventHandler?(sender.relatedColor ?? "")
  }
}

class ColorButton: UIButton {
  private let view = SelectionView()
  var relatedColor: String? {
    return backgroundColor?.hexValue
  }
  
  init() {
    super.init(frame: .zero)
    addSubview(view)
    
    view.fillSuperview(with: 5.0)
    
    view.backgroundColor = .white
    view.alpha = 0.0
  }
  
  required init?(coder: NSCoder) {
    fatalError()
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    layer.cornerRadius = frame.height / 2
    
    layer.borderColor = UIColor(hex: "#f0f0f0")?.cgColor
    layer.borderWidth = relatedColor?.lowercased().contains("ffffff") ?? false ? 2.0 : 0.0
  }
  
  override var isSelected: Bool {
    didSet {
      if let relatedColor = relatedColor {
        view.backgroundColor = relatedColor.lowercased().contains("ffffff") ? UIColor(hex: "#f0f0f0") : .white
      }
      
      UIView.animate(withDuration: 0.25) { [unowned self] in
        self.view.alpha = self.isSelected ? 1.0 : 0.0
      }
    }
  }
}

class SelectionView: UIView {
  override func layoutSubviews() {
    super.layoutSubviews()
    layer.cornerRadius = frame.height / 2
  }
}
