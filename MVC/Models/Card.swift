//
//  Card.swift
//  MVC
//
//  Created by Hyeon su Ha on 12/02/2020.
//  Copyright © 2020 Geektree0101. All rights reserved.
//

struct Card: Syncronizable {
  
  var id: Int = -1
  var title: String? = nil
  var content: String? = nil
  var isFollow: Bool = false
  
  func isSyncronizable(from value: Card?) -> Bool {
    return value?.id == self.id
  }
}
