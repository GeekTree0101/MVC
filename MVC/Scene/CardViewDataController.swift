protocol CardViewDataLogic: class {
  
  func cardViewData(error: Error?) -> CardView.ViewData
}

class CardViewDataController {
  
  var dataStore: CardDataStore?
  
}

extension CardViewDataController: CardViewDataLogic {
  
  func cardViewData(error: Error?) -> CardView.ViewData {
    
    if error != nil {

      return CardView.ViewData(
        title: "Error!",
        content: "you got error TT",
        isFollow: false
      )
    }
  
    return CardView.ViewData(
      title: dataStore?.card?.title,
      content: dataStore?.card?.content,
      isFollow: dataStore?.card?.isFollow == true
    )
  }
}
