//
//  CardService.swift
//  MVC
//
//  Created by Hyeon su Ha on 12/02/2020.
//  Copyright © 2020 Geektree0101. All rights reserved.
//

import PromiseKit

class CardService {
  
  public func getCard(_ id: Int) -> Promise<Card> {
    
    return .value(Card(
      id: id,
      title: "MVC is not your problem",
      content: "David, karrot",
      isFollow: false
    ))
  }
  
  public func follow(_ card: Card) -> Promise<Card> {
    var mutableCard = card
    mutableCard.isFollow = true
    mutableCard.content = "You're following"
    return [true, false].randomElement() == true
      ? .value(mutableCard)
      : .init(error: NSError(domain: "test", code: -1, userInfo: nil))
  }
  
  public func unfollow(_ card: Card) -> Promise<Card> {
    var mutableCard = card
    mutableCard.isFollow = false
    mutableCard.content = "Plz follow :]"
    return [true, false].randomElement() == true
      ? .value(mutableCard)
      : .init(error: NSError(domain: "test", code: -1, userInfo: nil))
  }
}
