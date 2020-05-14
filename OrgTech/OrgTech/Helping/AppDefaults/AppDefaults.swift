//
//  AppDefaults.swift
//  OrgTech
//
//  Created by Maksym Balukhtin on 16.02.2020.
//  Copyright © 2020 Maksym Balukhtin. All rights reserved.
//

import UIKit

enum AppDefaults {
  enum Colors {
    static let black = UIColor.black
    static let white = UIColor.white
    static let toolBar = UIColor.clear
    static let buttons = UIColor(red: 173/255, green: 216/255, blue: 230/255, alpha: 1.0)
    
    enum Text {
      static let `default` = UIColor.black
      static let specialOffer = UIColor.black
    }
    
    enum PageIndicator {
      static let current = UIColor.black
      static let `default` = UIColor.lightGray
    }
  }
  
  enum Images {
    static let logo = UIImage(named: "logo_small")
    
    enum Rating {
      static let empty = UIImage(named: "emptyStar")
      static let highlighted = UIImage(named: "highlightedStar")
      static let filled = UIImage(named: "filledStar")
    }
    
    enum Buttons {
      static let addButton = UIImage(named: "add")
      static let checkButton = UIImage(named: "checkMark")
      static let filterButton = UIImage(named: "filter")
    }
  }
  
  enum ControllerName {
    static let home = "Home"
    static let cart = "Cart"
    static let menu = "Menu"
    static let search = "Search"
  }
  
  enum TabIndicator {
    static let home = UITabBarItem(name: AppDefaults.ControllerName.home, image: UIImage(.home)?.resized(to: 30.0))
    static let cart = UITabBarItem(name: AppDefaults.ControllerName.cart, image: UIImage(.cart)?.resized(to: 30.0))
    static let menu = UITabBarItem(name: AppDefaults.ControllerName.menu, image: UIImage(.menu)?.resized(to: 30.0))
    static let search = UITabBarItem(name: AppDefaults.ControllerName.search, image: UIImage(.search)?.resized(to: 30.0))
  }
  
  enum Strings {
    enum Keys {
      static let cartCount = "cartCount"
      static let favouritesCount = "favouritesCount"
      static let filteredItems = "filteredItems"
    }
    
    enum Button {
      static let confirmButton = "Confirm"
      static let toCartButton = "To Cart"
      static let inCartButton = "In Cart"
      static let followButton = "Follow"
      static let unfollowButton = "Unfollow"
      static let done = "Done"
    }
    
    enum Label {
      static let searchTip = "Start searching by taping your query."
      static let searchEmpty = "Sorry, but nothing found by your query!"
      static let cartFollowEmpty = "Sorry, seems like there is nothing here!"
      static let reviewTip = "To leave review you need to enter you name, comment and leave rating!"
    }
    
    enum Placeholder {
      enum TextField {
        static let name = "Name"
        static let brand = "Brand"
        static let comment = "Comment"
        static let email = "E-mail"
        static let address = "Address"
        static let deliveryType = "Delivery Method"
      }
      
      static let search = "Search"
      static let color = "Select color:"
      static let price = "Select price range:"
      static let brand = "Select brand:"
      static let totalPrice = "Total cart price:"
    }
    
    enum AlertTitle {
      static let success = "Success"
      static let error = "Error"
    }
  }
}
