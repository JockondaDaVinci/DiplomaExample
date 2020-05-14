//
//  CategoryView.swift
//  OrgTech
//
//  Created by Maksym Balukhtin on 29.04.2020.
//  Copyright © 2020 Maksym Balukhtin. All rights reserved.
//

import UIKit

class CategoryView: BuildableView {
  //MARK: Subviews
  let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
  let emptyLabel = UILabel()
  
  override func addViews() {
    //add subviews into array
    [collectionView, emptyLabel].forEach{addSubview($0)}
  }
  
  override func anchorViews() {
    collectionView.fillSuperview()
    emptyLabel.fillSuperview()
  }
  
  override func configureViews() {
    backgroundColor = .white
    collectionView.backgroundColor = .white
    collectionView.showsVerticalScrollIndicator = false
    collectionView.showsHorizontalScrollIndicator = false
    collectionView.bounces = true
    
    collectionView.register(cell: CollectionViewCell.self)
    
    emptyLabel.font = .systemFont(ofSize: 17.0)
    emptyLabel.numberOfLines = 0
    emptyLabel.textAlignment = .center
    emptyLabel.textColor = .lightGray
    emptyLabel.text = "Sorry, seems like there is nothing here!"
  }
}

