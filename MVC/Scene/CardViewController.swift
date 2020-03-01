import MBProgressHUD

class CardViewController: ASViewController<CardView> {
  
  // MARK: - UI Components
  
  private lazy var refreshButtonItem = UIBarButtonItem(
    barButtonSystemItem: .refresh,
    target: self,
    action: #selector(refresh)
  )
  
  private lazy var presentNewVCButtonItem = UIBarButtonItem(
    barButtonSystemItem: .add,
    target: self,
    action: #selector(didTapAddBarButtonItem)
  )
  
  // MARK: - Props
  
  internal var modelController: CardModelLogic!
  internal var viewDataController: CardViewDataLogic!
  public var coordinateController: (CardCoordinateLogic & CardCoordinateDataPassing)?
  
  init() {
    super.init(node: .init())
    self.setup()
    self.title = "MVC"
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Setup controllers
  
  private func setup() {
    // define controllers
    
    let modelController = CardModelController()
    let viewDataController = CardViewDataController()
    let coordinateController = CardCoordinateController()
    
    // configure controllers
    
    viewDataController.dataStore = modelController
    
    coordinateController.dataStore = modelController
    coordinateController.viewController = self
    
    // setup controllers to scene(view controller)
    
    self.modelController = modelController
    self.viewDataController = viewDataController
    self.coordinateController = coordinateController
  }
  
  override func viewDidLoad() {
    
    super.viewDidLoad()
    self.setupBarButtonItems()
    self.reload()
    self.node.delegate = self
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.refresh()
  }
  
  private func setupBarButtonItems() {
    
    self.navigationItem.rightBarButtonItems = [
      self.presentNewVCButtonItem,
      self.refreshButtonItem
    ]
  }
  
}

// MARK: - Action

extension CardViewController {
  
  @objc public func reload() {
    
    modelController.getArticle()
      .map(on: .main) { self.viewDataController.cardViewData(error: nil) }
      .done { self.node.render(viewData: $0).setNeedsLayout() }
      .catch { _ in MBProgressHUD.messasge("Failed!", to: self.view) }
  }
  
  @objc public func refresh() {
    
    self.node.render(viewData: viewDataController.cardViewData(error: nil))
      .setNeedsLayout()
  }
  
  @objc private func didTapAddBarButtonItem() {
    
    self.coordinateController?.pushCardViewController()
  }
}

extension CardViewController: CardViewActionDelegate {
  
  func didTapFollowButton(node: CardView) {
    
    (node.followButtonNode.isSelected ? self.modelController.unfollow() : self.modelController.follow())
      .map(on: .main) { self.viewDataController.cardViewData(error: nil) }
      .recover { .value(self.viewDataController.cardViewData(error: $0)) }
      .done { node.render(viewData: $0).setNeedsLayout() }
  }
}
