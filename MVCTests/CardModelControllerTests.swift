import XCTest
import PromiseKit
@testable import MVC

class CardModelControllerTests: XCTestCase {
  
  // MARK: - Test Double Objects
  
  class SpyCardService: CardService {
    
    var getCardCalled: Int = 0
    var followCalled: Int = 0
    var unfollowCalled: Int = 0
    
    var getCardStub: Promise<Card> = .value(Card())
    var followStub: Promise<Card> = .value(Card())
    var unfollowStub: Promise<Card> = .value(Card())
    
    override func getCard(_ id: Int) -> Promise<Card> {
      getCardCalled += 1
      return getCardStub
    }
    
    override func follow(_ card: Card) -> Promise<Card> {
      followCalled += 1
      return followStub
    }
    
    override func unfollow(_ card: Card) -> Promise<Card> {
      unfollowCalled += 1
      return unfollowStub
    }
  }
  
  class MockCardModelController: CardModelController {
    
  }
  
  // MARK: - Before Each
  
  var mockCardModelController: MockCardModelController!
  var spyCardService: SpyCardService!
  
  override func setUp() {
    mockCardModelController = MockCardModelController()
    spyCardService = SpyCardService()
    mockCardModelController.service = spyCardService
    super.setUp()
  }
  
}

// MARK: - Get Article

extension CardModelControllerTests {
  
  func test_should_be_get_article() {
    // given
    spyCardService.getCardStub = .value(Card(id: 1))
    
    // when
    try! hang(mockCardModelController.getArticle())
    
    // then
    XCTAssertEqual(mockCardModelController.card?.id, 1)
    XCTAssertEqual(spyCardService.getCardCalled, 1)
  }
  
  func test_should_not_call_get_article_with_existed_card() {
    // given
    spyCardService.getCardStub = .value(Card(id: 100))
    mockCardModelController.card = Card(id: 1)
    
    // when
    try! hang(mockCardModelController.getArticle())
    
    // then
    XCTAssertEqual(mockCardModelController.card?.id, 1)
    XCTAssertEqual(spyCardService.getCardCalled, 0)
  }
}

// MARK: - Follow

extension CardModelControllerTests {
  
  func test_should_be_follow() {
    // given
    spyCardService.followStub = .value(Card(id: 1, isFollow: true))
    mockCardModelController.card = Card(id: 1, isFollow: false)
    
    // when
    try! hang(mockCardModelController.follow())
    
    // then
    XCTAssertEqual(mockCardModelController.card?.isFollow, true)
    XCTAssertEqual(spyCardService.followCalled, 1)
  }
}

// MARK: - Unfollow

extension CardModelControllerTests {
  
  func test_should_be_unfollow() {
    // given
    spyCardService.followStub = .value(Card(id: 1, isFollow: false))
    mockCardModelController.card = Card(id: 1, isFollow: true)
    
    // when
    try! hang(mockCardModelController.unfollow())
    
    // then
    XCTAssertEqual(mockCardModelController.card?.isFollow, false)
    XCTAssertEqual(spyCardService.unfollowCalled, 1)
  }
}
