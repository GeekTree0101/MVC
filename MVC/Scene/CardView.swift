// MARK: - UI Layout

protocol CardViewActionDelegate: class {
  
  func didTapFollowButton(node: CardView)
}

class CardView: ASDisplayNode, LayoutSpecBuildable {
  
  // ViewData is data for view, a.k.a ViewModel :]
  
  struct ViewData {
    
    var title: String?
    var content: String?
    var isFollow: Bool
  }
  
  enum Const {
    
    static let titleStyle: [NSAttributedString.Key: Any] = [
      .font: UIFont.boldSystemFont(ofSize: 30.0),
      .foregroundColor: UIColor.black
    ]
    
    static let contentStyle: [NSAttributedString.Key: Any] = [
      .font: UIFont.boldSystemFont(ofSize: 18.0),
      .foregroundColor: UIColor.darkGray
    ]
  }
  
  public let titleNode: ASTextNode2 = .init()
  
  public let contentNode: ASTextNode2 = .init()
  
  public let followButtonNode: ASButtonNode = {
    let node = ASButtonNode()
    node.contentEdgeInsets = .init(top: 20.0, left: 20.0, bottom: 20.0, right: 20.0)
    node.cornerRadius = 8.0
    node.backgroundColor = .blue
    
    node.setTitle(
      "Follow",
      with: .boldSystemFont(ofSize: 14.0),
      with: .white,
      for: .normal
    )
    
    node.setTitle(
      "Following",
      with: .boldSystemFont(ofSize: 14.0),
      with: .white,
      for: .selected
    )
    return node
  }()
  
  public weak var delegate: CardViewActionDelegate?
  
  override init() {
    super.init()
    self.backgroundColor = .white
    self.automaticallyManagesLayoutSpecBuilder(changeSet: .safeArea)
  }
  
  override func didLoad() {
    super.didLoad()
    self.followButtonNode.addTarget(
      self,
      action: #selector(didTapFollowButton),
      forControlEvents: .touchUpInside
    )
  }
  
  var layoutSpec: ASLayoutSpec {
    LayoutSpec {
      VStackLayout(
        spacing: 14.0,
        justifyContent: .center,
        alignItems: .center
      ) {
        titleNode.styled({ $0.shrink() })
        contentNode.styled({ $0.shrink() })
        followButtonNode
      }
    }
  }
  
  @objc func didTapFollowButton() {
    
    self.delegate?.didTapFollowButton(node: self)
  }
  
  public func render(viewData: ViewData) -> Self {
    // binding
    self.titleNode.attributedText =
      .init(string: viewData.title ?? "", attributes: Const.titleStyle)
    self.contentNode.attributedText =
      .init(string: viewData.content ?? "", attributes: Const.contentStyle)
    self.followButtonNode.isSelected = viewData.isFollow
    return self
  }

}
