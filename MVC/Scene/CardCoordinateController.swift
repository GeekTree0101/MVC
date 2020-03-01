protocol CardCoordinateLogic {
  
  func pushCardViewController()
}

protocol CardCoordinateDataPassing {
  
  var dataStore: CardDataStore? { get set }
}


class CardCoordinateController: CardCoordinateDataPassing {
  
  weak var viewController: CardViewController?
  var dataStore: CardDataStore?
  var dataDrain: ((CardDataStore?) -> Void)?
}

extension CardCoordinateController: CardCoordinateLogic {
  
  func pushCardViewController() {
    
    let targetViewController = CardViewController()
    
    // Data Passing to data store of child view controller
    
    targetViewController.coordinateController?.dataStore?.card = self.dataStore?.card
    
    // Navigate child view controller
    
    self.viewController?
      .navigationController?
      .pushViewController(targetViewController, animated: true)
  }
}
