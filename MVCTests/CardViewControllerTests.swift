import XCTest
import PromiseKit
import Nimble
@testable import MVC

class CardViewControllerTests: XCTestCase {
  
  class SpyCardView: CardView {
    
    var renderCalled: Int = 0
    
    override func render(viewData: CardView.ViewData) -> Self {
      renderCalled += 1
      return self
    }
  }
  
  class StubCardModelController: CardModelLogic {
    
    var getArticleStub: Promise<Void> = .value(())
    var followStub: Promise<Void> = .value(())
    var unfollowStub: Promise<Void> = .value(())
    
    func getArticle() -> Promise<Void> {
      
      return getArticleStub
    }
    
    func follow() -> Promise<Void> {
      
      return followStub
    }
    
    func unfollow() -> Promise<Void> {
      
      return unfollowStub
    }
  }
  
  class MockCardViewController: CardViewController {
    
    var modelControllerStub: CardModelLogic!
    var spyNode: SpyCardView!
    
    override var modelController: CardModelLogic! {
      get {
        return modelControllerStub
      }
      set {
        modelControllerStub = newValue
      }
    }
    
    override var node: CardView! {
      return spyNode
    }
    
    override init() {
      super.init()
    }
    
    required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }
  }
  
  var mockCardViewController: MockCardViewController!
  var stubCardModelController: StubCardModelController!
  
  override func setUp() {
    stubCardModelController = StubCardModelController()
    mockCardViewController = MockCardViewController()
    mockCardViewController.spyNode = SpyCardView()
    mockCardViewController.modelControllerStub = stubCardModelController
  }
  
}

// MARK: - Reload

extension CardViewControllerTests {
  
  func test_reload_should_be_call_render() {
    // given
    let node = SpyCardView()
    mockCardViewController.spyNode = node
    
    // when
    mockCardViewController.reload()
    
    // then
    expect(node.renderCalled).toEventually(equal(1))
  }
  
  func test_reload_should_not_be_call_render() {
    // given
    let node = SpyCardView()
    mockCardViewController.spyNode = node
    stubCardModelController.getArticleStub = .init(error: NSError(domain: "test", code: -1, userInfo: nil))
    
    // when
    mockCardViewController.reload()
    
    // then
    expect(node.renderCalled).toEventually(equal(0))
  }
  
}

// MARK: - Follow

extension CardViewControllerTests {
  
  func test_follow_should_be_call_render() {
    // given
    let node = SpyCardView()
    
    // when
    mockCardViewController.didTapFollowButton(node: node)
    
    // then
    expect(node.renderCalled).toEventually(equal(1))
  }
  
  func test_follow_should_be_call_render_on_error() {
    // given
    let node = SpyCardView()
    stubCardModelController.followStub = .init(error: NSError(domain: "test", code: -1, userInfo: nil))
    
    // when
    mockCardViewController.didTapFollowButton(node: node)
    
    // then
    expect(node.renderCalled).toEventually(equal(1))
  }
  
}
