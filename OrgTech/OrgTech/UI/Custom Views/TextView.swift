//
//  TextView.swift
//  OrgTech
//
//  Created by Maksym Balukhtin on 02.05.2020.
//  Copyright © 2020 Maksym Balukhtin. All rights reserved.
//

import UIKit

class TextView: UITextView {
  private let placeholderLabel = UILabel()
  var viewUnderline = UIView()
  var errorLabel = UILabel()
  
  var errorUnderlineColor: UIColor? = .red
  var editingUnderlineColor: UIColor? = .black
  var inactiveUnderlineColor: UIColor? = .lightGray
  
  var placeholder: String = "" {
    didSet {
      placeholderLabel.text = placeholder
    }
  }
  
  var textChanged: EventHandler<String>?
  var charCountChanged: EventHandler<Int>?
  
  override init(frame: CGRect, textContainer: NSTextContainer?) {
    super.init(frame: frame, textContainer: textContainer)
    
    addViews()
//    anchorViews()
    configureViews()
  }
  
  @available(*, unavailable) required init?(coder aDecoder: NSCoder) {
    fatalError("required init not implemented")
  }
  
  private func addViews() {
    [placeholderLabel, viewUnderline, errorLabel].forEach {
      addSubview($0)
    }
  }
  
  private func anchorViews() {
    viewUnderline.frame = CGRect(x: 0, y: frame.height - 2.0, width: frame.width, height: 2.0)
    
    let xPos = textContainer.lineFragmentPadding
    let yPos = textContainerInset.top - 2
    let width = frame.width - (xPos * 2)
    placeholderLabel.frame = CGRect(x: xPos, y: yPos, width: width, height: 21.0)
    
    errorLabel.frame = CGRect(x: 0, y: frame.height + 10.0, width: frame.width, height: 10.0)
  }
  
  private func configureViews() {
    delegate = self
    tintColor = .black
    font = .systemFont(ofSize: 17.0)
    viewUnderline.backgroundColor = .black
    
    placeholderLabel.sizeToFit()
    placeholderLabel.font = .systemFont(ofSize: 17.0)
    placeholderLabel.textAlignment = .natural
    placeholderLabel.textColor = .placeholderText
    
    errorLabel.textColor = errorUnderlineColor
    errorLabel.textAlignment = .left
    errorLabel.font = .systemFont(ofSize: 12.0)
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    anchorViews()
  }
}

extension TextView: UITextViewDelegate {
  func textViewDidChange(_ textView: UITextView) {
    placeholderLabel.isHidden = textView.text.count > 0
  }
  
  func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
    guard let _text = textView.text,
        let range = Range(range, in: _text) else {
            return false
    }
    let substringToReplace = _text[range]
    let count = _text.count - substringToReplace.count + text.count
    charCountChanged?(count)
    
    let updatedText = _text.replacingCharacters(in: range, with: text)
    textChanged?(updatedText)
    
    return count < 150
  }
}
