//
//  HomePageView.swift
//  OrgTech
//
//  Created by Maksym Balukhtin on 22.04.2020.
//  Copyright © 2020 Maksym Balukhtin. All rights reserved.
//

import UIKit

class HomePageView: BuildableView {
  //MARK: Subviews
  let segmentControl = UISegmentedControl()
  let contentView = UIView()
  
  override func addViews() {
    //add subviews into array
    [segmentControl, contentView].forEach{addSubview($0)}
  }
  
  override func anchorViews() {
    segmentControl
      .anchorTop(safeAreaLayoutGuideAnyIOS.topAnchor, 0.0)
      .anchorLeft(leftAnchor, 0.0)
      .anchorRight(rightAnchor, 0.0)
      .anchorHeight(44.0)
    
    contentView
      .anchorTop(segmentControl.bottomAnchor, 0.0)
      .anchorLeft(segmentControl.leftAnchor, 0.0)
      .anchorRight(segmentControl.rightAnchor, 0.0)
      .anchorBottom(safeAreaLayoutGuideAnyIOS.bottomAnchor, 0.0)
  }
  
  override func configureViews() {
    backgroundColor = .white
    ["Top", "Sale"].enumerated().forEach { index, item in
      segmentControl.insertSegment(withTitle: item, at: index, animated: false)
    }
    segmentControl.selectedSegmentIndex = 0
  }
}

