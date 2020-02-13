import PromiseKit

protocol CardDataStore {
  
  var cardID: Int { get set }
  var card: Card? { get set }
}

protocol CardModelLogic: class {
  
  func getArticle() -> Promise<Void>
  func follow() -> Promise<Void>
  func unfollow() -> Promise<Void>
}

class CardModelController: CardDataStore {
  
  var cardID: Int = -1
  var card: Card?
  
  var service: CardService = .init()
  
}

extension CardModelController: CardModelLogic {
  
  func getArticle() -> Promise<Void> {
    
    if self.card == nil {
      return self.service.getCard(cardID)
        .get({ self.card = $0 })
        .asVoid()
    }
    
    return .value(())
  }
  
  func follow() -> Promise<Void> {
    
    guard let card = self.card else {
      return Promise.init(
        error: NSError(domain: "card is nil", code: -1, userInfo: nil)
      )
    }
    
    return service.follow(card)
      .get({ self.card = $0 })
      .asVoid()
  }
  
  func unfollow() -> Promise<Void> {
    
    guard let card = self.card else {
      return Promise.init(
        error: NSError(domain: "card is nil", code: -1, userInfo: nil)
      )
    }
    
    return service.unfollow(card)
      .get({ self.card = $0 })
      .asVoid()
  }
}
