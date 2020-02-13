protocol CardCoordinateLogic {
  
  func pushCardViewController()
}

protocol CardCoordinateDataPassing {
  
  var dataStore: CardDataStore? { get set }
  var dataDrain: ((CardDataStore?) -> Void)? { get set }
  func dataSyncronizer()
}

extension CardCoordinateDataPassing {
  
  func dataSyncronizer() {
    self.dataDrain?(dataStore)
  }
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
    
    // Data Drain from data store of child view controller
    
    targetViewController.coordinateController?.dataDrain = { [weak self] newData in
      guard let self = self else { return }
      self.dataStore?.card = newData?.card
      self.viewController?.refresh()
      self.dataSyncronizer()
    }
    
    // Navigate child view controller
    
    self.viewController?
      .navigationController?
      .pushViewController(targetViewController, animated: true)
  }
}
