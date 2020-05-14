//
//  BuildableTableViewCell.swift
//  OrgTech
//
//  Created by Maksym Balukhtin on 22.04.2020.
//  Copyright © 2020 Maksym Balukhtin. All rights reserved.
//

import UIKit

class BuildableTableViewCell<View, Object>: UITableViewCell where View: UIView {
  var mainView: View
  
   override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
     self.mainView = View()
     super.init(style: style, reuseIdentifier: reuseIdentifier)
     contentView.addSubview(mainView)
     mainView.fillSuperview()
   }
  
   @available (*, unavailable) required init?(coder aDecoder: NSCoder) {
     fatalError("required init not implemented")
   }
  
  func config(with object: Object) {
    
  }
}
