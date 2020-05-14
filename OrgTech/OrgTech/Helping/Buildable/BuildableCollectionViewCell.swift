//
//  BuildableCollectionViewCell.swift
//  OrgTech
//
//  Created by Maksym Balukhtin on 22.04.2020.
//  Copyright © 2020 Maksym Balukhtin. All rights reserved.
//

import UIKit

class BuildableCollectionViewCell<View, Object>: UICollectionViewCell where View: UIView {
  var mainView: View
  
  override init(frame: CGRect) {
    self.mainView = View()
    super.init(frame: frame)
    contentView.addSubview(mainView)
    mainView.fillSuperview()
  }
  
  @available (*, unavailable) required init?(coder aDecoder: NSCoder) {
    fatalError("required init not implemented")
  }
  
  func config(with object: Object) { }
}
