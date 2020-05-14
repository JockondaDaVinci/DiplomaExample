//
//  HomeView.swift
//  OrgTech
//
//  Created by Maksym Balukhtin on 16.02.2020.
//  Copyright © 2020 Maksym Balukhtin. All rights reserved.
//

import UIKit

class HomeView: BuildableView {
  //MARK: Subviews
  let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
  
  override func addViews() {
    //add subviews into array
    [collectionView].forEach{addSubview($0)}
  }
  
  override func anchorViews() {
    collectionView.fillSuperview()
  }
  
  override func configureViews() {
    collectionView.backgroundColor = .white
    collectionView.showsVerticalScrollIndicator = false
    collectionView.showsHorizontalScrollIndicator = false
    collectionView.bounces = true
    
    collectionView.register(cell: CollectionViewCell.self)
  }
}
